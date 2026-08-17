## Linewize PPPC settings
This process allows a standard user to enable the Classroom Manager screen recording setting as a standard user. Then at the next check-in, it will lock them out from being able to turn it off.

Screen Recording has to be enabled to see the individual students devices when a class is started in Classroom Manager. If it is not enabled, you will only see the students wallpaper.

## Using the Linewize PPPC Settings
1. Create an Extension attribute called "Screen Recording Access - Linewize" and enter the path to the Linewize classroom plugin in the script.
2. Create a Smart Group with the criteria of the EA having the value of "Enabled"
    - **Title:** Screen Recording Enabled - Linewize
    - **Criteria:** "Screen Recording Access - Linewize" like "Enabled"
3. Create a Config Profile to set the PPPC settings allowing a standard user to modify the Screen Recording Settings
    - **Scope:** 
        - Target - Computers that have linewize installed (you decide this scope)
        - Exclude - "Screen Recording Enabled - Linewize" smart group
4. Create a Config Profile to lock the PPPC settings NOT allowing a standard user to modify the Screen Recording Settings (setting not applied)
    - **Scope:** 
        - Target - "Screen Recording Enabled - Linewize" smart group

## Additional Settings (Optional)
An additional smart group could be made to see all the devices that have linewize installed but the screen recording not activated. You could then show this on your Jamf Dashbaord to quickly see which students have not yet enabled the screen recording or it has been reset for some reason.