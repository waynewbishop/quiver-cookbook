import Playgrounds
import Quiver

// Decide When Retrieval Is Good Enough
// Retrieval always returns something — even an off-topic question gets
// a ranked list, because ranking only asks "which chunk is closest?",
// never "is the closest one actually close?". Handing weak context to a
// language model invites a confident wrong answer, so the honest move
// when retrieval is poor is to say "I don't know". RetrievalResult
// keeps the full score field and its statistics visible so we can make
// that call, and isAboveGate composes two checks: the top hit is good
// on its own terms (an absolute floor), or it stands clearly above the
// rest of the field (an outlier z-score). Quiver supplies the
// composition; the thresholds are ours.

#Playground("Decide When Retrieval Is Good Enough") {

    // The same word-vector table as Recipe 78, including a few words
    // from an unrelated topic so an off-topic question still embeds —
    // it scores low instead of disappearing.
    let embeddings: [String: [Double]] = [
        "dough":       [0.2, 0.6, 0.5, 0.0],
        "rise":        [0.1, 0.8, 0.2, 0.0],
        "slowly":      [0.1, 0.7, 0.2, 0.0],
        "slow":        [0.1, 0.7, 0.2, 0.0],
        "proof":       [0.1, 0.9, 0.2, 0.0],
        "flavor":      [0.2, 0.6, 0.2, 0.0],
        "yeast":       [0.1, 0.9, 0.1, 0.0],
        "knead":       [0.1, 0.3, 0.9, 0.0],
        "smooth":      [0.1, 0.2, 0.8, 0.0],
        "shape":       [0.1, 0.2, 0.9, 0.0],
        "bake":        [0.8, 0.2, 0.2, 0.0],
        "hot":         [0.9, 0.1, 0.0, 0.0],
        "oven":        [0.9, 0.1, 0.1, 0.0],
        "heat":        [0.9, 0.1, 0.0, 0.0],
        "crust":       [0.7, 0.2, 0.1, 0.0],
        "temperature": [0.9, 0.1, 0.0, 0.0],
        "phone":       [0.0, 0.0, 0.1, 0.9],
        "battery":     [0.0, 0.0, 0.1, 0.9],
        "charge":      [0.1, 0.0, 0.2, 0.8]
    ]

    // The same embedder and chunker as Recipe 78.
    struct TableEmbedder: Embedder {
        let table: [String: [Double]]
        func embed(_ text: String) -> [Double]? {
            text.tokenize().embed(using: table).meanVector()
        }
    }

    struct ParagraphChunker: Chunker {
        func chunk(_ text: String) -> [Chunk] {
            text.components(separatedBy: "\n\n").asChunks()
        }
    }

    let passage = """
    Let the dough rise slowly. A slow proof develops flavor as the yeast works.

    Knead the dough until smooth, then shape it.

    Bake in a hot oven. The heat sets the crust.
    """

    var index = EmbeddingIndex<Chunk>(embedder: TableEmbedder(table: embeddings))
    for chunk in passage.chunked(using: ParagraphChunker()) {
        index.add(chunk.text, label: chunk)
    }

    // Retrieve, read the score field, and gate. The floor and outlierZ
    // parameters have no defaults on purpose — the right values depend
    // on the embedder and the corpus, so Quiver supplies the
    // composition (floor OR outlier) and never the cutoff. For this
    // table embedder, 0.30 and 3.0 are our chosen policy.
    func report(_ question: String) {
        let result = index.retrieve(question, k: 1)
        let meanScore = String(format: "%.4f", result.mean)
        let spread = String(format: "%.4f", result.standardDeviation)
        let topScore = String(format: "%.4f", result.topScore)
        let topZ = String(format: "%.2f", result.topZScore)
        let isRelevant = result.isAboveGate(floor: 0.30, outlierZ: 3.0)
        print("Q: \(question)")
        print("  field: mean \(meanScore), spread \(spread)")
        print("  top hit: \(topScore), \(topZ) standard deviations above the field")
        if isRelevant {
            print("  gate: passed — hand the top chunk to the model")
        } else {
            print("  gate: failed — answer honestly that the document does not cover this")
        }
    }

    // A question the document answers: the top hit clears the floor
    // easily, so the gate passes.
    report("what temperature to bake at")
    // Q: what temperature to bake at
    //   field: mean 0.5568, spread 0.3841
    //   top hit: 0.9997, 1.15 standard deviations above the field
    //   gate: passed — hand the top chunk to the model

    // An off-topic question: it still gets a ranked list, but the top
    // hit clears neither bar, so the gate turns it away.
    report("how do I charge my phone battery")
    // Q: how do I charge my phone battery
    //   field: mean 0.0820, spread 0.0539
    //   top hit: 0.1442, 1.15 standard deviations above the field
    //   gate: failed — answer honestly that the document does not cover this

    // Both z-scores read 1.15 — no accident. With n scores, a sample
    // z-score can never exceed (n − 1) / √n, which for three scores is
    // about 1.15. The outlier path cannot fire on a corpus this small;
    // the absolute floor is the live path here. The z ≥ 3.0 check earns
    // its keep on a larger field — a dozen chunks or more — where one
    // hit standing far above the rest is a real signal.
}
