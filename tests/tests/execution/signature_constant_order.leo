/*
seed = 123456789

[case]
program = "constant_signature.aleo"
function = "signature_message"
input = ["sign1sq2kkhl3dz8dx8cuag0rglcu0s3t9gcwqwn9t3f8jukxzmdszsqmkzcxd5a36gv4jn2llms3qkqdztp0fek6c9a3f9uyafu07c4rup8esm5elrqqunzqzmac7kzutl6zk7mqht3c0m9kg4hklv7h2js0qmxavwnpuwyl4lzldl6prs4qeqy9wxyp8y44nnydg3h8sg6ue99qkcgamsx"]

[case]
program = "constant_signature.aleo"
function = "field_message"
input = ["5field"]
*/

const SIGNER: address = aleo1zecnqchckrzw7dlsyf65g6z5le2rmys403ecwmcafrag0e030yxqrnlg8j;
const FIELD_SIGNATURE: signature = sign1sq2kkhl3dz8dx8cuag0rglcu0s3t9gcwqwn9t3f8jukxzmdszsqmkzcxd5a36gv4jn2llms3qkqdztp0fek6c9a3f9uyafu07c4rup8esm5elrqqunzqzmac7kzutl6zk7mqht3c0m9kg4hklv7h2js0qmxavwnpuwyl4lzldl6prs4qeqy9wxyp8y44nnydg3h8sg6ue99qkcgamsx;
const SIGNATURE_SIGNATURE: signature = sign1nxwl6v4h0zlxzpu6v0t4a49wung6qyc39zn5hguamcj0qv5t9spq03n0xgp7k7cs72gc3zc0qrfmuwuyjcje8zmsyzv756xym8ns5q8esm5elrqqunzqzmac7kzutl6zk7mqht3c0m9kg4hklv7h2js0qmxavwnpuwyl4lzldl6prs4qeqy9wxyp8y44nnydg3h8sg6ue99qkap3wxd;

program constant_signature.aleo {
    fn signature_message(message: signature) {
        let folded = signature::verify(SIGNATURE_SIGNATURE, SIGNER, FIELD_SIGNATURE);
        assert(folded);
        assert_eq(folded, signature::verify(SIGNATURE_SIGNATURE, SIGNER, message));
        assert(!signature::verify(FIELD_SIGNATURE, SIGNER, SIGNATURE_SIGNATURE));
        assert(!signature::verify(SIGNATURE_SIGNATURE,
            aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px, FIELD_SIGNATURE));
    }

    fn field_message(message: field) {
        let folded = signature::verify(FIELD_SIGNATURE, SIGNER, 5field);
        assert(folded);
        assert_eq(folded, signature::verify(FIELD_SIGNATURE, SIGNER, message));
        assert(!signature::verify(FIELD_SIGNATURE, SIGNER, 6field));
    }

    @noupgrade
    constructor() {}
}
