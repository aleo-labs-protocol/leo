program test.aleo {
    fn main(allowed: bool) {
        assert(test.aleo::allowed);
    }

    @noupgrade
    constructor() {}
}
