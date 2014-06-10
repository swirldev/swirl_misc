# When user and swirl-generated plots are mixed a trick is necessary to restore them in correct order if the user exits the lesson partway through and resumes at a later time. This file illustrates the trick.
print(qplot(date, psavert, data=economics))
