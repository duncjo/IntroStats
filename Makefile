## ********************************************************************* ##
## Copyright 2016                                                        ##
## David Farmer, Greg Hartman, Alex Jordan, Carly Vollet                 ##
##                                                                       ##
## This file is part of APEX Calculus                                    ##
##                                                                       ##
## ********************************************************************* ##

#######################
# DO NOT EDIT THIS FILE
#######################

#   1) Make a copy of Makefile.paths.original
#      as Makefile.paths, which git will ignore.
#   2) Edit Makefile.paths to provide full paths to the root folders
#      of your local clones of the project repository and the mathbook
#      repository as described below.
#   3) The files Makefile and Makefile.paths.original
#      are managed by git revision control and any edits you make to
#      these will conflict. You should only be editing Makefile.paths.

##############
# Introduction
##############

# This is not a "true" makefile, since it does not
# operate on dependencies.  It is more of a shell
# script, sharing common configurations

######################
# System Prerequisites
######################

#   install         (system tool to make directories)
#   xsltproc        (xml/xsl text processor)
#   xmllint         (only to check source against DTD)
#   <helpers>       (PDF viewer, web browser, pager, Sage executable, etc)

#####
# Use
#####

#	A) Navigate to the location of this file
#	B) At command line:  make <some-target-from-the-options-below>

# The included file contains customized versions
# of locations of the principal components of this
# project and names of various helper executables
include Makefile.paths

###################################
# These paths are subdirectories of
# the project distribution
###################################
SRC       = $(PRJ)/src
IMAGESRC  = $(SRC)/images
OUTPUT    = $(PRJ)/output
STYLE     = $(PRJ)/style
XSL       = $(PRJ)/xsl

# The project's root file
MAINFILE  = $(SRC)/index.ptx

# These paths are subdirectories of
# the PreTeXt distribution
PTXXSL = $(PTX)/xsl

# These paths are subdirectories of the output
# folder for different output formats
PRINTOUT   = $(OUTPUT)/print
HTMLOUT    = $(OUTPUT)/html
IMAGESOUT  = $(OUTPUT)/images

# The WeBWorK server we use
#SERVER = "(https://webwork-dev.aimath.org,anonymous,anonymous,anonymous,anonymous)"
SERVER = "(https://webwork.pcc.edu,orcca,orcca,anonymous,orcca)"
#SERVER = http://localhost

html:
	install -d $(HTMLOUT)
	-rm -rf $HTMLOUT/knowl
	install -d $(HTMLOUT)/knowl
	install -d $(HTMLOUT)/images
	install -d $(OUTPUT)
	install -d $(OUTPUT)/images
#	-rm $(HTMLOUT)/*.html
#	cp -a $(IMAGESOUT) $(HTMLOUT)
	cp -a $(IMAGESRC) $(HTMLOUT)
	cd $(HTMLOUT); \
	xsltproc -xinclude $(PTXXSL)/mathbook-html.xsl $(SRC)/index.ptx
	google-chrome-stable http://localhost/

check:
	install -d $(OUTPUT)
	-rm $(OUTPUT)/jingreport.txt
	-jing $(PTX)/schema/pretext.rng $(SRC)/index.ptx > $(OUTPUT)/jingreport.txt
	@if [ -s $(OUTPUT)/jingreport.txt ]; then less $(OUTPUT)/jingreport.txt; else echo "No errors found"; fi