# SystemVerilog-1800-2012 README

This extension incorporates syntax highlighting and snippet support for `IEEE Std 1800-2012 - SystemVerilog` hardware description language and `Universal Verification Methodology` (UVM) in [Visual Studio Code](https://code.visualstudio.com/).

# Note
Please note, that I've created this extension to create a comfortable environment for my workflow. It **does not** and **does not even aim** to fullfill the needs of everyone, especially since I am much more involved in the UVM based verification side than in design. It will not give you any kind of built in support for any FOSS or industry tools (eg.: Verilator, VCS, ModelSim, etc.) by default, so please don't expect that.

At this stage the extension does not have instantation pattern or language server support neither. However you can expect proper syntax recognization, scoping and snippets for both SystemVerilog and UVM.

If you still like the extension, please feel free to throw me a 'Hi!' if we meet at a conference or exhibition or even on LinkedIn. I'd like to hear about your experiences! :)

# Features
* Syntax highlighting and basic syntax checking capabilites for SystemVerilog.
* Scope based start end checking for *module-endmodule*, *fork-join*, *begin-end*, etc. constructs to help debugging via the highlighting
* Formatting and indentation support (via the built in command: **Reindent Lines**) to VS Code's natural limitations on *well written code*
* UVM class and type integration (mostly done, in progress)
* Snippet support for the verification side of SV and UVM

![Screenshot](https://github.com/gvekony/sv-1800-2012/raw/master/images/sv_screenshot_monokai_pro.png)

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
* Phases in both short extern versions and fully fledged ones, eg.: `uvm_extern_phase_build`, `uvm_phase_pre_configure`, etc.

![Snippets](https://github.com/gvekony/sv-1800-2012/raw/master/images/vs_code_snippets.gif)

## Indentation rules
* Indentation rules are added for the common constructs of SystemVerilog (eg.: module-endmodule, begin-end, etc.) for VS Code's `reindent` function
* As VS Code uses tmLanguage (TextMate) styled rules for this, there is no multiline support, eg. block comments can break your indentation if a line starts with begin for example.

## Extra folding rules
* Extra folding (but not indentation) rules are set for SystemVerilog compiler directives (eg.: ifdef-endif, pragma protect begin-end, etc.)
* Similarly to indentation rules, line breaked `` `pragma protect begin`` break this feature.

# Release Notes
## [1.0.27]
### Changes
* Added `uvm_sequence` functions snippet.
* Updated the main UVM phase snippet definition with proper objection related `uvm_info` macros.
* Added whitespace guide snippet aligned for `$sformatf()`.
* Added `c_` and `if_` to variable naming conventions to represent combinatorical wires and interfaces. (Design Naming Convention)
### Bugfixes
* Added missing `extensionKind` to package.json thus enabled remote install for SSH development.
* Added indent pattern for `(local|protected|static) virtual` functions and tasks.

# License and source information

[MIT](https://github.com/gvekony/sv-1800-2012/blob/master/LICENSE.md) &copy; **Gergo Vekony**

The source can be found @ [GitHub](https://github.com/gvekony/sv-1800-2012)

