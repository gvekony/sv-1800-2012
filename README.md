# SystemVerilog-1800-2012 README

This extension incorporates syntax highlighting and snippet support for `IEEE Std 1800-2012 - SystemVerilog` hardware description language and `Universal Verification Methodology` (UVM) in [Visual Studio Code](https://code.visualstudio.com/).

# Features
* Syntax highlighting and basic syntax checking capabilites for SystemVerilog.
* Scope based start end checking for *module-endmodule*, *fork-join*, *begin-end*, etc. constructs to help debugging via the highlighting
* Formatting and indentation support (via the built in command: **Reindent Lines**) to VS Code's natural limitations on *well written code*
* UVM class and type integration (mostly done, in progress)
* Snippet support for the verification side of SV and UVM

![Screenshot](https://github.com/gvekony/sv-1800-2012/raw/master/images/sv_screenshot_vs_code_dark.png)

## Fully or partially supported SystemVerilog-2012-1800 features
* checkers
* classes (abstract, concrete)
* comments, attributes, various conventional highlights (accessors, numbers, etc.)
* constraint blocks
* coverage, covergroups
* interfaces, modports, clocking blocks
* modules
* packages
* programs
* tasks and functions (extern, virtual, etc.)
* gate level and user-defined primitives

### SV Snippets
SystemVerilog snippets are available with a `sv_` prefix.

* Containers: sv_module, sv_interface, sv_class
* Language constructs: sv_block_parallel, sv_block_sequential, sv_if, sv_if_blocks, sv_if_blocks_labels

As VS Code uses clever search in words and snippets pressing `sq` will most likely result in `sv_block_sequential` so you don't need to type the whole snippet expression. :)

## UVM
* UVM classes and functions are partially supported, implementation is work in progress.
* UVM config_db calls, macros and types are partially supported via highlighting and snippets.

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
## [1.0.14]
### Bugfixes
* Fixed reindent issue for virtual and pure virtual functions and tasks.

### Features
* Added NaturalDocs compatible comment lines for SystemVerilog and UVM snippet constructs.

## 1.0.13
* [#2] Fixed unscoped property declaration in generate block. Due to tmLanguage limitations property-endproperty constructs will now be scoped in _all_ begin-end blocks as they cannot be differentiated from generate block begin-end blocks. Also changed the scoping of *genvar* keyword; it is moved to the net_types group.

## 1.0.12
* Fixed reindent bug. One ')' was lost somewhere in the process.

## 1.0.10 & 1.0.11
### Features
* Marketplace related changes and fixes.

## 1.0.9
### Features
* Added several snippet to support quick UVM class deployment. Sequence item received a specialized snippet and also the do_ sequence item method boilerplates are added. (eg.: uvm_sequence_item, uvm_sequence_item_do_copy etc.)
* Snippets are uniformized and end-of-line added to most of them.
* Added snippets for separators/headers (eg.: sv_separator_full, sv_separator_block etc.)
* Added protected|static|local method qualifiers to indentation rules.

# Known bugs
* AND property/sequence operator and AND gate level primitive is not yet distinguished.
* Limited support on module declaration's import statements (dependent on line breaks)
* Limited support on unindented code's folding markers (editor limitation)


# License and source information

[MIT](https://github.com/gvekony/sv-1800-2012/blob/master/LICENSE.md) &copy; **Gergo Vekony**

The source can be found @ [GitHub](https://github.com/gvekony/sv-1800-2012)

