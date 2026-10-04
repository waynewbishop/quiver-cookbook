import Playgrounds
import Quiver

// Retrieve a Passage for a Question
// Recipes 21 and 77 rank short phrases in a catalog. Retrieval scales
// that idea to a document: cut it into chunks, embed each chunk once,
// then rank the chunks against a question by meaning. This is the half
// of retrieval-augmented generation that Quiver owns — the top chunks
// become the context a language model answers from. Three pieces snap
// together: a Chunker decides where the document is cut, an Embedder
// turns text into a vector, and an EmbeddingIndex holds the embedded
// corpus and ranks a query against it.

#Playground("Retrieve a Passage for a Question") {

    // A small vocabulary of word vectors (real ones have 50-300
    // dimensions). The axes loosely encode heat, fermentation, and
    // handling; the fourth carries an unrelated topic used in Recipe 79.
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

    // An Embedder turns text into a vector — here by averaging word
    // vectors, exactly as in Recipe 77. Words missing from the table
    // drop out; a text with no known words returns nil, and the index
    // skips it rather than storing garbage.
    struct TableEmbedder: Embedder {
        let table: [String: [Double]]
        func embed(_ text: String) -> [Double]? {
            text.tokenize().embed(using: table).meanVector()
        }
    }

    // A Chunker decides where a document is cut. Splitting on blank
    // lines gives paragraph chunks; asChunks() trims, drops the empties,
    // and numbers what remains. Quiver ships the contract, not the
    // chunker — where to cut is our decision.
    struct ParagraphChunker: Chunker {
        func chunk(_ text: String) -> [Chunk] {
            text.components(separatedBy: "\n\n").asChunks()
        }
    }

    // The document to answer from — three short paragraphs about bread.
    let passage = """
    Let the dough rise slowly. A slow proof develops flavor as the yeast works.

    Knead the dough until smooth, then shape it.

    Bake in a hot oven. The heat sets the crust.
    """

    // Build the index: each chunk is embedded once, at ingest, and
    // stored beside its vector. At search time only the query is
    // embedded — the corpus math is already done.
    var index = EmbeddingIndex<Chunk>(embedder: TableEmbedder(table: embeddings))
    for chunk in passage.chunked(using: ParagraphChunker()) {
        index.add(chunk.text, label: chunk)
    }

    // The question shares no words with the winning chunk. "temperature"
    // sits near "hot", "oven", and "heat" in the vector table, so the
    // baking chunk rises to the top by meaning, not by keyword.
    let question = "what temperature to bake at"
    let result = index.retrieve(question, k: 3)

    print("Q: \(question)")
    for hit in result.hits {
        print("#\(hit.rank) chunk \(hit.label.index) (\(String(format: "%.4f", hit.score))): \(hit.label.text)")
    }
    // #1 chunk 2 (0.9997): Bake in a hot oven. The heat sets the crust.
    // #2 chunk 0 (0.3558): Let the dough rise slowly. A slow proof develops flavor as the yeast works.
    // #3 chunk 1 (0.3149): Knead the dough until smooth, then shape it.

    // The index ranks and exposes its math; it does not judge relevance.
    // Whether 0.9997 is good enough to act on is the caller's decision —
    // Recipe 79 shows how to make it.
}
