program test.aleo {
    fn main(allowed: bool) {
        assert(allowed);
    }

    @noupgrade
    constructor() {}
}
