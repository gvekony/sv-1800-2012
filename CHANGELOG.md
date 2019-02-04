# Change Log (Functional Changes)
## [1.0.14]
### Bugfixes
* Fixed reindent issue for virtual and pure virtual functions and tasks.

### Features
* Added NaturalDocs compatible comment lines for SystemVerilog and UVM snippet constructs.

## [1.0.13]
### Bugfixes
* [#2] Fixed unscoped property declaration in generate block. Due to tmLanguage limitations property-endproperty constructs will now be scoped in _all_ begin-end blocks as they cannot be differentiated from generate block begin-end blocks. Also changed the scoping of *genvar* keyword; it is moved to the net_types group.

## [1.0.12]
### Bugfixes
* Fixed reindent bug. One ')' was lost somewhere in the process.

## [1.0.10] & [1.0.11]
### Features
* Marketplace related changes and fixes.

## [1.0.9]
### Features
* Added several snippet to support quick UVM class deployment. Sequence item received a specialized snippet and also the do_ sequence item method boilerplates are added. (eg.: uvm_sequence_item, uvm_sequence_item_do_copy etc.)
* Snippets are uniformized and end-of-line added to most of them.
* Added snippets for separators/headers (eg.: sv_separator_full, sv_separator_block etc.)
* Added protected|static|local method qualifiers to indentation rules.

## [1.0.8]
### Features
* Better support of UVM source code, eg.: /* local */ extern functions, oneliner tasks and functions, etc.
* Minor bugfixes in UVM phase snippets.

## [1.0.7]
### Features
* Added external stubs for UVM phases; and also added UVM_runtime_phases to the snippet library.

## [1.0.6]
### Features
* Added net and variable types to the compilation unit namespace
* Compiler directives and system tasks are now correctly included in the appropriate scopes
* External function declaration now correctly scopes the function name and the return type

## [1.0.5]
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

## [1.0.4]
* Added snippet demonstration gif
* Added correct scoping to externally defined functions, tasks, modules, etc.
* End label handling of module, interface, etc. constructs moved to the punctuation region.
* End labels are handled well even when the previous end(construct) keyword is stray and illegal.

## [1.0.2]
* Corrected indent pattern on open curly braces
* Added special formal types to parenthesis (sequence, untyped)
* Fixed attribute bug in always(*) constructs
* Added operators to covergroup body (iff operator)
* Added nettype user defined type
* Added property and sequence to clocking block

## [1.0.1]
### License information and screenshots are added

## [1.0.0]
### Initial release
#### The addon supports the following features
* classes
* comments, attributes, various conventional highlights (accessors, numbers, etc.)
* constraint blocks
* coverage
* interfaces
* modules
* packages
* tasks and functions

#### Limited support on the following features
* checkers
* programs
* user-defined primitives
* UVM related classes, types, macros and functions

#### Unsupported features and problems
* specify blocks
* Logical '<=' and the assignment '<=' are not differentiated yet. Solution: logical operators shall only be applied inside of a parenthesis.(?)
* A.1.2: SystemVerilog source text: { package_import_declaration } in module_nonansi_header, module_ansi_header is not supported.
