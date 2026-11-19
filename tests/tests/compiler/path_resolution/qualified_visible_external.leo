export const allowed: bool = true;

program dependency.aleo {
    fn entry() {}

    @noupgrade
    constructor() {}
}

// --- Next Program --- //

import dependency.aleo;

program test.aleo {
    fn qualified(allowed: bool) {
        assert(dependency.aleo::allowed);
    }

    @noupgrade
    constructor() {}
}
