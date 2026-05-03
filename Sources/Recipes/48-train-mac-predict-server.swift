import Playgrounds
import Quiver
import Foundation

// Train on Mac, Predict on Server
// A Pipeline is a value type. That means it can be trained on one
// machine, encoded to JSON, shipped as a file, and decoded on a
// different machine — no shared memory, no model server, no
// retraining. This recipe shows the full handoff in a single file:
// the encode step represents what happens on a developer's Mac,
// and the decode step represents what happens at server startup
// inside a Vapor app or other Swift backend.

#Playground("Train on Mac, Predict on Server") {

    // --- On the Mac: train and serialize ---
    let features: [[Double]] = [[1, 2], [2, 3], [5, 8], [6, 9], [7, 10]]
    let labels = [0, 0, 1, 1, 1]
    let trained = Pipeline.fit(features: features, labels: labels, k: 3)

    // Encode the pipeline — this is the bytes you would write to disk
    // or check into the server's resource bundle
    let payload = try JSONEncoder().encode(trained)
    print("Payload size: \(payload.count) bytes")

    // --- On the server: decode at startup, predict on requests ---
    let served = try JSONDecoder().decode(
        Pipeline<KNearestNeighbors>.self, from: payload
    )

    // A request arrives with raw features — Pipeline scales internally
    let incoming: [[Double]] = [[3, 4], [6, 8]]
    let predictions = served.predict(incoming)
    print("Predictions: \(predictions)")  // [0, 1]
}
