# DRAGON

## *D*igital *R*econstruction of *A*ncient *G*raphical *O*DFs (e*N*abling quantitative comparative analysis)

DRAGON is a MATLAB-based tool for the digitization of pole figures and ODFs from images published in literature, developed by the MONSTER Research Group at the University of Florida in order to enable quantitative comparison of experimental and simulated texture data with old experiments where the only remnant of the original texture data is a scan of a scan of a journal and the pole figure looks like it was painted by Salvador Dali. DRAGON allows users to upload images of pole figures and manually add datapoints with known values on the pole figure (generally at contour lines and minima/maxima). Projecting that data onto the sphere then interpolating between the contours provides an estimation of the formerly-analog pole figure which can be evaluated for any pole orientation. With the data for enough unique poles, DRAGON uses the MTEX algorithm to reconstruct an ODF from the pole figures, in much the same way one uses MTEX to reconstruct an ODF from X-ray diffraction data.

Right now, DRAGON is rudimentary, not entirely free of bugs, a bit memory intensive, and is restricted to specifically to pole figures (and primarily those represented by contour lines rather than smooth color maps). Additionally, while [MTEX's algorithm](https://doi.org/10.1107/S0021889808030112) for reconstructing ODFs from pole figure data is validated and quite consistent, DRAGON is still very early in the V&V/UQ process. All that said, most of the time, it does exactly what it's supposed to.

The primary purpose of releasing DRAGON at this point in the development cycle is to get user feedback! If you try it out and have bugs/crashes/errors, please report them here as [issues](https://github.com/MONSTERgroup/DRAGON/issues), and if you questions/comments that are not directly related to bugs, we will do our best to answer them in the [discussions](https://github.com/MONSTERgroup/DRAGON/discussions) tab. If you digitize a published pole figure and are willing to share that data with us for testing purposes, we would greatly appreciate it; the more unique users and pole figures/ODFs in our data set, the easier it will be to improve DRAGON. Feature requests and suggestions for improvements are also welcome (though we make no guarantees that a requested feature will be added in a reasonable amount of time, or at all).

## Requirements

- MATLAB R2021b (MATLAB 9.11)
- MATLAB Image Processing Toolbox (Version 11.4 for MATLAB R2021b)
- [MTEX crystallographic toolbox](https://mtex-toolbox.github.io) (Version [5.8.1](https://mtex-toolbox.github.io/download) or [Latest Release](https://github.com/mtex-toolbox/mtex/releases/latest))

## Getting Started

1. Download and unpack [MTEX v.5.8.1](https://mtex-toolbox.github.io/download) (or clone the [MTEX GitHub repository](https://github.com/mtex-toolbox/mtex))

2. Run `startup_DRAGON()` with no arguments with the DRAGON repository folder as the working directory.
  
    On the first run (or any startup where the configuration file cannot be found), DRAGON creates an XML configuration file: **DRAGON.cfg**. 
        
    When DRAGON.cfg is created, a dialog will present the option to save the path to your MTEX directory, to start MTEX externally once, and to always start MTEX externally:
    - Saving the path allows DRAGON to initialize MTEX as part of its own startup process. Choosing this dialog option will initiate a file browser dialog, where you should choose the base MTEX directory, which contains **startup_mtex.m**. Should you want to change the location of your MTEX installation, or update to a new version of MTEX, the path stored in DRAGON.cfg can be directly edited: `<mtex_path>$path_goes_here</mtex_path>`. Alternatively, deleting DRAGON.cfg before starting DRAGON will repeat this dialog. (In future versions of DRAGON, the configuration file will likely contain more information that you may not want to reset, so this method is not recommended, but until I add configuration editing to the GUI, deleting DRAGON.cfg is the only graphical way to reset the path to the MTEX install).
    - Choosing to start MTEX externally (once) will check to see if an MTEX environment is already active (by attempting to run the `crystalSymmetry('cubic')` command), and will continue if MTEX is active, or will quit DRAGON if MTEX is not already active. If DRAGON quits, start MTEX, then restart DRAGON. Choosing this option sets the MTEX path in the config to `<mtex_path>session</mtex_path>`, which will be reset to no flag after DRAGON is restarted. The next time DRAGON starts, the **Save MTEX Path** dialog will reappear.
    - Choosing to start MTEX externally (always) will check to see if an MTEX environment is already active (by attempting to run the `crystalSymmetry('cubic')` command), and will continue if MTEX is active, or will quit DRAGON if MTEX is not already active. If DRAGON quits, start MTEX, then restart DRAGON. Choosing this option sets the MTEX path in the config to `<mtex_path>never</mtex_path>`. With this flag set, the **Save MTEX Path** dialog will not appear unless the flag in DRAGON.cfg is edited, or DRAGON.cfg is deleted.
    Saving the MTEX path should be the best option for most users, the others are given to accommodate users with workflows that might otherwise be disrupted by automatically initializing MTEX.
    
## Using DRAGON

DRAGON has two windows: the primary GUI window, and the interactive plot window. DRAGON reuses the same this same figure window for any pole figure image that requires user interaction (previewed pole figures and reconstructed ODFs are plotted in new figure windows). There is currently no method for regenerating that interactive plot window if it is closed, and DRAGON will have to be restarted to regenerate the window.

### Initial ODF Setup

When DRAGON starts up, the Workspace column has an ODF node, and 3 informational nodes that display the lattice (crystal symmetry), spherical projection type, and the interpolation method assigned to the ODF. These can be changed at any time using the dropdown menus under the ODF heading on the right.

Ensure that the lattice matches that of the pole figure. The default lattice symmetry is *cubic*, and the user may select from the 7 primitive lattices. This step should be completed before anything else, as the common unique poles are calculated based on this selection.

Set the spherical projection and linear interpolation methods. The default projection is *equal angle* (stereographic/Wulff), with *equal distance* and *equal area* (Lambert azimuthal/Schmidt) projections available. The default for interpolation is *linear*, with *spherical harmonic* approximation as a second option. (The spherical harmonic approximation is not yet recommended, as using it efficiently requires changing the bandwidth value for the approximation, which we have not yet implemented a UI for.) Neither the projection nor the interpolation method needs to be set until you are ready to **Preview** the pole figure or **Compute** the final ODF reconstruction.

### Pole Figure

Begin a pole figure reconstruction by clicking **New: Pole** under the Workspace. Select the Pole Figure node in the workspace to enable the UI elements under the Pole Figure heading.

Select the proper Miller indices for the pole in the pole dropdown. Due to a quirk in how MTEX generates lists of unique directions for a crystal symmetry, it tends to select members with negative indices as the prototypical member of the family of symmetrically equivalent directions. While not as conventional or visually appealing for labeling plots, DRAGON's reconstruct calculations will not be affected so long as care is taken to ensure that the value selected in the dropdown is equivalent to the direction of the original pole figure for the given crystal symmetry.

Set the desired range of values for contours, minima, and maxima using the *Define Levels* text box above **Preview** in the Pole Figure section. There are two methods to define these values:
- **As a comma-separated list** where spaces are unnecessary but allowed. Brackets/braces/parentheses, like when defining a MATLAB array, should not be included.
- **As a linspace** which is not an entirely accurate name, because it functions like MATLAB's `:` operator instead of like the linspace function. The `:` operator creates a list starting at some value, increasing linearly by a step value, and continuing until it reaches or exceeds a terminator value, wherein the final value is included in the list if it is equal to the terminator, but excluded if it is greater than the terminator. The syntax for is `start:step:terminate`, and the DRAGON linspace syntax is the same, but a comma separated list can also be appended after a `+` operator to add values not created by the linspace. For example, `1:2.5:14+0, 17.3` will generate the list `[0, 1, 3.5, 6, 8.5, 11, 13.5 17.3]`.
Use the dropdown to select the correct method, the press the **Define Levels** button to apply the list to the pole figure node that is selected in the Workspace. The informational node under the pole figure node will update to reflect the change.

Click the **Load Image** button to open a file browser dialog to import an image file (.jpg and .png work, many others should work but haven't been tested). The image should appear in the Interactive Plot Window. The Interactive Plot Window can be resized like a normal window, and it tends to be easiest to work with if the Plot window is full screen on one monitor, with the GUI on a second monitor (a second monitor is not necessary to use DRAGON, however.)

Click the **Transform Image** button and mouse over the image in the Interactive Plot Window. Crosshairs that extend the entire length of the window should appear (if not, make sure the Plot Window is in focus), and while the crosshairs are active, click the center of the pole figure. After the marker is placed, click somewhere on the circumference of the pole figure circle. The image will be cropped and centered with a blue circle plotted around the edge of the pole figure. If the circle is not well aligned, this process can be repeated several times. If part of the pole figure is cropped away, the entire image can be reloaded with the **Load Image** button (with a warning dialog confirming that you want to replace the image an any contour data associated with it.)

After loading and transforming the image, the UI elements under the Contour heading should become available. Use the toggle buttons to select whether you are going to add minima, maxima, or contour-representative data points to the pole figure image, then select the appropriate value from the Level dropdown. Press the **Collect Points** button and the mouse cursor will again change to crosshairs over the Interactive Plot Window.

Click with the primary mouse button to place a point at the crosshair position. Add as many points as necessary (all of which should have the same level and extremum character). The Backspace key or the Left Arrow key can be used to undo a misplaced point if necessary. Press the Enter/Return key or the secondary mouse button to end collection (actually, any key that does not have another purpose will end the collection, but that may be restricted in the future to just Enter/Return/secondary mouse button. When the collection is ended, the points are locked into place and cannot be changed. (A method for selecting and removing points from previous collections is planned but not implemented.)

When the collection has ended and the cursor returns to its normal form, the extrema toggles and levels dropdown can be changed to the next desired combination. If either of those are changed while the collection is still active, all points that were placed during that collection will have the value that was selected at the time the collection is closed, rather than those which were active when the collection opened.

At any point, the **Preview** button will perform the interpolation based on the datapoints added to the currently selected pole figure. The preview figure windows can be closed, and datapoints can be added to the pole figure after previewing.

**Save Points** in the Contour section will write the image, the position and size of the boundary circle, and the positions and values of collected points in a MATLAB .mat data file. **Load Points** will open a file browser dialog to select a .mat of saved points, then overwrite the image, boundary circle, and store points of the currently selected pole figure. An image must be loaded for the selected pole figure in order to load points, but that can be a dummy image file, which will be replace when the points are loaded. The image does not need to be transformed or centered to load points.

Repeat this section for as many pole figures as will contribute to the final ODF. In my experience, it tends to be easier to run DRAGON once for each pole figure, save the points, and in a final run, load all of the points and reconstruct the ODF. Keeping track of the handles/markers for the clicked datapoints seems to be particularly memory intensive, so splitting the data point collection into separate sessions appears to help.

### Computing ODF

When data points have been collected for all pole figures, the **Compute** button under the ODF heading will combine the individual pole figures into a single, compound MTEX `PoleFigure` object, then reconstruct the ODF. After computing the ODF, a save dialog will save the compound pole figure object, the ODF, and the scaling/factors calculated during the ODF reconstruction.
