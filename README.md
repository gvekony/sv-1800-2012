# SystemVerilog-1800-2012 README

This extension incorporates syntax highlighting and snippet support for `IEEE Std 1800-2012 - SystemVerilog` hardware description language and `Universal Verification Methodology` (UVM) in [Visual Studio Code](https://code.visualstudio.com/).

# Features
* Syntax highlighting and basic syntax checking capabilites for SystemVerilog.
* Scope start end checking for *module-endmodule*, *fork-join*, *begin-end*, etc.
* UVM class and type integration (mostly done, in progress)
* Snippet support for the verification side of SV and UVM

![Screenshot](https://github.com/gvekony/sv-1800-2012/raw/master/images/sv_screenshot_vs_code_dark.png)

## Fully or partially supported SystemVerilog-2012-1800 features
* checkers
* classes
* comments, attributes, various conventional highlights (accessors, numbers, etc.)
* constraint blocks
* coverage, covergroups
* interfaces, modports, clocking blocks
* modules
* packages
* programs
* tasks and functions
* user-defined primitives

### SV Snippets
SystemVerilog snippets are available with a `sv_` prefix.

* Containers: sv_module, sv_interface, sv_class
* Language constructs: sv_block_parallel, sv_block_sequential, sv_if, sv_if_blocks, sv_if_blocks_labels

As VS Code uses clever search in words and snippets pressing `sq` will most likely result in `sv_block_sequential` so you don't need to type the whole snippet expression. :)

## UVM
UVM classes, macros and functions are partially supported, implementation is work in progress.

### UVM Snippets
The most common UVM boilerplates are available with an `uvm_` prefix.

* UVM containers: uvm_class_object, uvm_class_object_params, uvm_class_component, uvm_class_component_params
* Macros (field macros are purposely omitted): uvm_macro_info, uvm_macro_warning, uvm_macro_error, uvm_macro_object_utils, etc.
* Phases: uvm_phase_build, uvm_phase_connect, etc.

![Snippets](https://github.com/gvekony/sv-1800-2012/raw/master/images/vs_code_snippets.gif)

## Indentation rules
* Indentation rules are added for the common constructs of SystemVerilog (eg.: module-endmodule, begin-end, etc.) for VS Code's `reindent` function
* As VS Code uses tmLanguage (TextMate) styled rules for this, there is no multiline support, eg. block comments can break your indentation if a line starts with begin for example.

## Extra folding rules
* Extra folding (but not indentation) rules are set for SystemVerilog compiler directives (eg.: ifndef-endif, pragma protect begin-end, etc.)
* Similarly to indentation rules, line breaked `` `pragma protect begin`` break this feature.

# Release Notes

## 1.0.10 & 1.0.11
### Features
* Marketplace related changes and fixes.

## 1.0.9
### Features
* Added several snippet to support quick UVM class deployment. Sequence item received a specialized snippet and also the do_ sequence item method boilerplates are added. (eg.: uvm_sequence_item, uvm_sequence_item_do_copy etc.)
* Snippets are uniformized and end-of-line added to most of them.
* Added snippets for separators/headers (eg.: sv_separator_full, sv_separator_block etc.)
* Added protected|static|local method qualifiers to indentation rules.

## 1.0.8
### Features
* Better support of UVM source code, eg.: /* local */ extern functions, oneliner tasks and functions, etc.
* Minor bugfixes in UVM phase snippets.

## 1.0.7
### Features
* Added external stubs for UVM phases; and also added UVM_runtime_phases to the snippet library.

## 1.0.6
### Bugfixes
* Added net and variable types to the compilation unit namespace
* Compiler directives and system tasks are now correctly included in the appropriate scopes
* External function declaration now correctly scopes the function name and the return type

## 1.0.5
### Features
* Added folding rules for all langauage constructs eg.: module-endmodule, class-endclass etc., to be foldable even when the indentation of the code is not perfect. Exceptions: begin-end, fork-join, as the editor has certain limitations; eg.: a line of 'end else begin' breaks the processing. Reindent still works on these lines and folding by indentation is possible
* Also indentation regex rules are now more verbose; for some reason the folding markers work this way
* Added support for user defined macro calls
### Bugfixes
* Compiler directives now scope correctly; standardized end-of-line termination on several scopes
* Global clocking without a clocking_identifier now scopes correctly
* Standardized end label scoping of classes, properties and sequences
* Typedef with queue types will scope correctly
* Module instantiation, function call parameters now scope correctly

# Known bugs
* AND property/sequence operator and AND gate level primitive is not yet distinguished.
* Limited support on module declaration's import statements (dependent on line breaks)
* Limited support on unindented code's folding markers (editor limitation)


# License and source information

[MIT](https://github.com/gvekony/sv-1800-2012/blob/master/LICENSE.md) &copy; **Gergo Vekony**

The source can be found @ [GitHub](https://github.com/gvekony/sv-1800-2012)

