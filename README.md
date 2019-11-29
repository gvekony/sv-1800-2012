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

* UVM containers, eg.: uvm_class_object, uvm_class_object_params, uvm_class_component, uvm_class_component_params, etc.
* ConfigDB accesses, eg.: uvm_config_db_get, uvm_config_db_set, uvm_config_db_get_guarded, etc.
* Factory instantiations, eg.: uvm_factory_instantiation_object, uvm_factory_instantiation_component
* Macros (field macros are purposely omitted): uvm_macro_info, uvm_macro_warning, uvm_macro_error, uvm_macro_object_utils, etc.
* Phases in both short extern versions and fully fledged ones, eg.: uvm_extern_build_phase, uvm_pre_configure_phase, etc.

![Snippets](https://github.com/gvekony/sv-1800-2012/raw/master/images/vs_code_snippets.gif)

## Indentation rules
* Indentation rules are added for the common constructs of SystemVerilog (eg.: module-endmodule, begin-end, etc.) for VS Code's `reindent` function
* As VS Code uses tmLanguage (TextMate) styled rules for this, there is no multiline support, eg. block comments can break your indentation if a line starts with begin for example.

## Extra folding rules
* Extra folding (but not indentation) rules are set for SystemVerilog compiler directives (eg.: ifndef-endif, pragma protect begin-end, etc.)
* Similarly to indentation rules, line breaked `` `pragma protect begin`` break this feature.

# Release Notes
## [1.0.24]
### Changes
* Fixed and added proper support (autocomplete, stray checking, etc.) for all three kinds of paranthesis (Curly, Square, Round).
* UVM types and enum values received a major overhaul.
* Refactored the typedef scoping rules to have more flexibility regarding unpacked vectorized typedefs.
* Proper support of unbound expressions via `$`.
* Added snippets for factory overrides (`uvm_factory_inst_override`, `uvm_factory_type_override`).

### Bugfixes
* Folding markers end bug fixed; it consumed the rest of the file after the last fold.
* Component factory instantiation snippet was missing a `)`.

## [1.0.22]
### Changes
* Cleared up `uvm_config_db_get_guarded` snippet to be more user friendly.
* Added UVM Factory instantiation snippets. (`uvm_object_factory_instantiation`, `uvm_component_factory_instantiation`)
* Added UVM objection snippet (`uvm_objection_block`) to be available in task contexts.

## [1.0.20]
### Changes
* Changed sv_guard snippet to automatically use uppercase defines with `.` replaced to `_`.
* Changed the SV module and interface container snippets to default the name to the file name.
* Changed the SV module and interface snippets to point out proper `package_import_declaration` placement. By importing packages here, the package contents are available even in the parameter and port list and the import does not happen in the compilation unit/global namespace, thus avoiding confusions and overrides in various simulators. (See SV-LRM-2017: Syntax23-1 for more details.)
* Changed the SV function and task snippets to default the class scope to the file name.
* Changed the UVM phase snippets to default the class scope to the file name.

### Bugfixes
* Fixed reindent feature to ignore the `disable fork` and `wait fork` statements in the indentation increase.

# License and source information

[MIT](https://github.com/gvekony/sv-1800-2012/blob/master/LICENSE.md) &copy; **Gergo Vekony**

The source can be found @ [GitHub](https://github.com/gvekony/sv-1800-2012)

