######################################################################
# Full disclosure: this technique utilizes recursive "make", which is
# generally regarded as a "bad thing". However, when interfacing any
# Makefile with some other build system, there is usually no other
# option than to invoke the external build system, which -- if the
# external build system is also make-based -- means using recursive
# "make". Fortunately, most of the negative effects of recursive
# "make" are mitigated when the boundaries of the Makefiles are also
# boundaries of unrelated projects, since this usually means the
# projects' dependency graphs are nearly completely separate.
######################################################################

# Here is the rule that builds the external project. Since this
# external project is make-based, we just run make in the external
# project's directory. Incidentally, this rule also allows us to run
# "make foobar" if, for any reason, we want to build just the external
# project.
.PHONY: foobar
foobar:
	@${MAKE} -C foobar

# Making a phony target a prerequisite of the real files that are
# built by the external build system ensures that we will always run
# "make" in the external project. This is necessary since Boilermake
# has no way of knowing if the external project's build products are
# up-to-date (Boilermake has no knowledge of the external project's
# dependency graph). It is up to the external build system to
# determine if anything is out-of-date and must be rebuilt.
#
# If these build products do get updated by the external build system,
# then Boilermake will see that they have been updated and will then
# rebuild anything that it knows depends on them (in the case of this
# example, "app" will be relinked if "libfoo.a" or "libbar.a" are
# updated by the external build system).
#
# Due to an unfortuname quirk of "make" (or at least GNU "make"), the
# real files MUST have a recipe or else "make" will assume that the
# files are up-to-date before the prerequisite's (foobar's) recipe has
# been run. So, here I've added a "do-nothing" recipe that just
# invoke's the shell's ":" builtin. This "do-nothing" recipe will be
# run once for each target listed in this rule. This is one reason why
# the "make" command is not specified here, but is instead specified
# in the recipe for the phony foobar target. This way, the external
# build system only gets invoked once.
foobar/libfoo.a foobar/libbar.a: foobar
	@:

# Finally, here are some rules to allow us to also clean the external
# project when we do "make clean" in the Boilermake project.
clean: foobar_clean

.PHONY: foobar_clean
foobar_clean:
	@${MAKE} -C foobar clean
