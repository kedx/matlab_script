Matlab GUI for SDF
========================

A Matlab GUI used to generate figures from SDF data file.

###What

Every time generate a figure from a SDF file, a long command which has many parameters and long file names is needed to type in the command window without any mistakes. Such a business is boring and takes a lot of time doing repeating works.

The goal of this program is to give a graphic user interface to get people out of the long command typing business. Using only a mouse pointer to generate figures by selecting or listing different parameters.

###How

To get started, put this folder along with your datafile folders.

Start Matlab and change work directory to this folder.

Type "my_gui" to start the GUI program.

The files being saved is at '../pic' folder by default.

###Description of source files

cut.m is used to plot a 1D line figure.
draw.m is used to plot a  2D contour plot figure.
den_log.m is used to plot a  2D contour plot figure in log10.
en.m is used to plot a energy spectrum figure.
seps.m is used to save figures in 'eps' or 'pdf' formats.
lv.m is used to list variables in the selected datafile.
gd.m is used to read the SDF file.
x_px is used to plot phase space.

###Finally

This program is under programming and unfinished. Welcome to tell bugs to me and help improve this program.