---
id: structure
title: Structure of a Leo Program
sidebar_label: Program Structure
---

[general tags]: # "program, constant, import, record, struct, mapping"

## Layout of a Leo Program

A Leo program contains declarations of a [Program](#program), a [Constructor](#constructor), [Constants](#constant), [Imports](#import)
, [Structs](#struct), [Records](#record), [Mappings](#mappings), [Interfaces](./programs_in_practice/interfaces.md), and functions.
Declarations are locally accessible within a program file.
If you need a declaration from another Leo file, you must import it.

### Program

A program is a collection of code (its functions) and data (its types) that resides at a program ID on the Aleo blockchain. A program is declared as `program {name}.{network} { ... }`, with the body delimited by curly braces.

For the canonical list of which declarations belong inside vs. Outside the `program { ... }` block, the program-ID naming rules, and import semantics, see [Project Layout](./layout.md#programs).

```leo file=../code_snippets/layout/main_example/src/main.leo#file
```

### Constructor

Declare exactly one `constructor() { ... }` inside each `program { ... }` block. A constructor takes no parameters and returns no value. The network runs it when you deploy the program and on every upgrade. If a check fails, the network rejects the deployment or upgrade. The constructor logic is fixed at the first deployment.

Choose one annotation to set the upgrade policy. For `@noupgrade`, `@admin`, or `@checksum`, leave the constructor body empty. The compiler generates the checks. For `@custom`, write the checks in the constructor body.

```leo file=../code_snippets/upgradability/noupgrade/src/main.leo#file
```

In a custom constructor, use [`std::ctx`](./standard_library.md#stdctx) to read the program’s address, edition, owner, or checksum. Edition `0` identifies the initial deployment. The following constructor uses the edition to apply different checks during an upgrade.

```leo file=../code_snippets/upgradability/timelock/src/main.leo#file
```

If your constructor calls a `final fn` from another program, metadata accessors inside that helper refer to the program that defines it. For example, suppose the constructor in `child.aleo` calls an edition check defined in `test.aleo`. Inside the helper, `std::ctx::edition()` reads the edition of `test.aleo`. If the helper rejects edition `2` and `test.aleo` is at edition `2`, the check fails even on the first deployment of `child.aleo`.

To check the calling program’s edition, read `std::ctx::edition()` in its constructor and pass that value to the helper. You can share the same comparison across programs in a [library function](./libraries.md).

See [Upgrading Programs](../guides/program_upgradability.md) for annotation arguments, examples of each upgrade policy, and guidance on recompiling an existing constructor.

### Constant

A constant is declared as `const {name}: {type} = {expression};`.
Constants are immutable, and the right-hand side must be an expression evaluatable at compile time.

Constants can be declared in three scopes:

- **Global scope** (outside the `program` block in `main.leo`): accessible anywhere in the same file.
- **Local scope** (inside a function body): accessible only within that function.
- **Module scope**: applies to each non-`main.leo` source file in the package. Module files do not contain a `program` block. They can only declare `const`, `struct`, `fn`, and `interface`. Use `path::to::module::CONST_NAME` to access the constant in the same package. See [Modules](./layout.md#modules).

Constants are also supported in [libraries](./libraries.md), which are separate packages containing reusable code. A library's root file and its submodules may declare constants, accessible from any dependent package as `library::CONST_NAME` or `library::path::to::submodule::CONST_NAME`.

**Accessibility across packages:** An importing program can access global constants with `program_name.aleo::CONST_NAME`. Use `program_name.aleo::path::to::submodule::CONST_NAME` to access a constant in an imported program submodule. This access requires a dependency compiled from Leo source. Precompiled `.aleo` stubs do not contain the submodule type information that resolution requires.

```leo file=../code_snippets/structure/constants/src/main.leo#scopes
```

**Supported types:** Constants support all integer types, `bool`, `field`, `group`, `scalar`, and `address`. They also support tuples, arrays, and structs composed of these types.

**Compile-time expressions:** The right-hand side of a constant declaration must be evaluatable at compile time. Valid right-hand sides include:

- Literal values (for example, `42u32`, `true`, `1field`)
- References to previously declared constants
- Arithmetic, bitwise, and comparison expressions over constants (for example, `MAX * 2u64`, `!FLAG`)
- Tuple, array, and struct expressions whose components are themselves compile-time constants

```leo file=../code_snippets/structure/constants/src/main.leo#expressions
```

### Import

An import is declared as `import {filename}.aleo;`. The dependency resolver pulls the imported program from the network or the local `imports/` directory. See [Imports](./layout.md#imports) for the declaration syntax and the [Dependencies guide](../guides/dependencies.md) for resolution rules.

```leo file=../code_snippets/layout/import_only/src/main.leo#snippet showLineNumbers
```

### Mappings

A mapping is declared as `mapping {name}: {key-type} => {value-type}`.
Mappings contain key-value pairs and are stored on chain.

```leo file=../code_snippets/structure/declarations/src/main.leo#mapping
```

### Storage

A storage variable is declared as `storage {name}: {type}`. Storage variables contain singleton values. They are declared at program scope and are stored on chain, similar to mappings.

```leo file=../code_snippets/structure/declarations/src/main.leo#storage_var
```

A storage vector is declared as `storage {name}: [{type}]`. Storage vectors contain dynamic lists of values of a given type. They are declared at program scope and are stored on chain, similar to mappings.

```leo file=../code_snippets/structure/declarations/src/main.leo#storage_vec
```

### Struct

A struct data type is declared as `struct {name} {}`.
Structs contain component declarations `{name}: {type},`.

```leo file=../code_snippets/structure/declarations/src/main.leo#struct showLineNumbers
```

### Record

A [record](https://docs.aleo.org/learn/core-concepts/public-and-private-state#private-state) data type is declared as `record {name} {}`. A record name must not contain `aleo`. It must not prefix another record name **declared in the same program**. This check does not apply across imported programs. It is a snarkVM requirement.

Records contain component declarations `{visibility} {name}: {type},`. Names of record components must not contain the keyword `aleo`.

The visibility qualifier may be specified as `constant`, `public`, or `private`. If no qualifier is provided, Leo defaults to `private`.

Each record must contain an `owner` component of type `address`, as shown below. A record function input also requires the `_nonce: group` and `_version: u8` components. Do not declare these components in the Leo program. The compiler inserts them automatically.

```leo file=../code_snippets/data_types/demo/src/main.leo#token_record showLineNumbers
```
