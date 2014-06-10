# Autodetection re-evaluates every expression which the user enters.
# If the expression results in a plot, two plots may appear. Hence,
# when having the user enter plot commands, autodetection should be
# turned off as follows:
AUTO_DETECT_NEWVAR <- FALSE

# However, this means the course author should detect user-created variables
# when appropriate. The answer test, creates_new_var() can be used for
# for the purpose, but it also re-evaluates the expression which the user
# entered so care must be taken. 