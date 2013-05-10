pceas
=====

I recently needed to fix a nasty core dump that was happening when building my last demo under linux. Turns out pceas did not really enforce the 32-char max. symbol name length rule, so it went crazy when you had really long symbol names.
I patched it so it issues a fatal error when a symbol name is too long, and also upped the limit to 64 chars.

From what I'm seeing, a few different versions of pceas are floating around the internets: Tomaitheous' release seemed to be the most recent, so that's the one I patched.

