// Copyright (C) 2019-2026 Provable Inc.
// This file is part of the Leo library.

// The Leo library is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// The Leo library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with the Leo library. If not, see <https://www.gnu.org/licenses/>.

use crate::CompilerState;
use leo_ast::{Expression, Intrinsic};

mod assigner;
pub use assigner::*;

mod block_to_function_rewriter;
pub use block_to_function_rewriter::*;

pub(crate) mod function_effects;
pub(crate) use function_effects::function_writes_state;

mod rename_table;
pub use rename_table::*;

mod replacer;
pub use replacer::*;

mod item_walkers;
pub use item_walkers::*;

mod symbol_access_collector;
pub use symbol_access_collector::*;

mod symbol_table;
pub use symbol_table::*;

mod tree_node;
pub use tree_node::ConditionalTreeNode;

mod type_table;
pub use type_table::*;

/// Returns true if `expr` can be removed without changing eager evaluation.
///
/// This is stricter than [`Expression::is_pure`]: source-level operations that
/// can lower to assertions or storage reads must still be evaluated even when
/// their result is unused.
pub(crate) fn expression_can_be_discarded(expr: &Expression, state: &CompilerState) -> bool {
    expression_can_be_discarded_with(expr, state, |child| expression_can_be_discarded(child, state))
}

pub(crate) fn expression_can_be_discarded_with(
    expr: &Expression,
    state: &CompilerState,
    operand_can_be_discarded: impl FnMut(&Expression) -> bool,
) -> bool {
    match expr {
        Expression::Path(path) => !path_is_storage_read(path, state),
        Expression::Intrinsic(intr) => {
            Intrinsic::from_symbol(intr.name, &intr.type_parameters).is_some_and(|intrinsic| {
                // Unwrapping can assert, and vector operations read storage.
                !matches!(intrinsic, Intrinsic::OptionalUnwrap | Intrinsic::VectorGet | Intrinsic::VectorLen)
                    && intrinsic.is_pure()
                    && intr.arguments.iter().all(operand_can_be_discarded)
            })
        }
        _ => expr.is_pure_with(
            &|id| state.types.resolve(state.type_table.get(&id).expect("Types should be assigned.")),
            operand_can_be_discarded,
        ),
    }
}

fn path_is_storage_read(path: &leo_ast::Path, state: &CompilerState) -> bool {
    path.try_global_location()
        .and_then(|location| state.symbol_table.lookup_global(location.program, location))
        .is_some_and(|var| {
            var.declaration == symbol_table::VariableType::Storage
                && var.type_.as_ref().is_none_or(|type_| !type_.is_mapping() && !type_.is_vector())
        })
}
