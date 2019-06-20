namespace Brilliant {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;

    operation QuantumMain(a : Int, b: Int) : (Int, Int) {
        // Define the message.
        let message = [a, b];
        // Message($"Message is: {message}");

        mutable message1 = 0;
        mutable message2 = 0;

        using ( (AliceQ, BobQ) = (Qubit(), Qubit()) ) {
            // Prepare the Bell state.
            PrepareBell(AliceQ, BobQ);

            // Alice encodes the message
            Encode(AliceQ, message);

            // Alice sends her qubit to Bob, who decodes the message
            Decode(AliceQ, BobQ);

            // Measure the qubits and report result.
            set (message1, message2) = ExtractMessage(AliceQ, BobQ);
     
            // Return all qubits to the |0> state before finishing with them.
            Reset(AliceQ); Reset(BobQ); 
        } 
            // Return 
        return (message1, message2);
    }
    operation Encode(AliceQ : Qubit, message : Int[]) : Unit {
        // Encode the message into Alice's qubit
        if (message[0] == 0 and message[1] == 0) {
            // No operation.
        } elif (message[0] == 0 and message[1] == 1) {
            X(AliceQ);
        } elif (message[0] == 1 and message[1] == 0) {
            Z(AliceQ);
        } elif (message[0] == 1 and message[1] == 1) {
            Z(AliceQ);
            X(AliceQ);
        }
    }
    operation Decode(AliceQ : Qubit, BobQ : Qubit) : Unit {
        // Decode the message from the two qubits. 
        CNOT(AliceQ, BobQ);
        H(AliceQ); 
    }
    operation PrepareBell(AliceQ : Qubit, BobQ : Qubit) : Unit {
        H(AliceQ);
        CNOT(AliceQ, BobQ);
    }
    operation ExtractMessage(AliceQ : Qubit, BobQ : Qubit) : (Int, Int) {
        let resultAlice = M(AliceQ);
        let resultBob = M(BobQ);
        return (ResultArrayAsInt([resultAlice]), ResultArrayAsInt([resultBob])) ;
    }
}