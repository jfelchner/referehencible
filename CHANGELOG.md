Version v1.0.0 - April 10, 2015
================================================================================

Fixed
--------------------------------------------------------------------------------
  * Added required parenthesis

Version v0.5.1 - March 26, 2015
================================================================================

Added
--------------------------------------------------------------------------------
  * rubocop configuration
  * deploy script
  * circle.yml
  * Rubygems settings

Version v0.5.0 - June 25, 2014
================================================================================

Feature
--------------------------------------------------------------------------------
  * Allow either UUID or Hex-based reference IDs

Version v0.4.0 - June 21, 2014
================================================================================

Feature
--------------------------------------------------------------------------------
  * Allow reference number length to be customizable

Version v0.3.0 - May 1, 2014
================================================================================

  * Abstract the generation of the reference number into its own Referehencible
    method
  * Fix bundled version number

Version v0.2.0 - April 8, 2014
================================================================================

  * Convert referehencible over so that it has the ability to generate
    references for any number of attributes and add scopes for each one
  * Add badges

Version v0.1.1 - March 27, 2014
================================================================================

  * Fix incorrect validation length
  * Fix Date.today in 1.9.2 which does not exist
  * Add development dependencies and make specs run on Travis and report back to
    Code Climate and notify Slack

Version v0.1.0 - March 19, 2014
================================================================================

  * Remove comments
  * Switch from RVM to rbenv
  * Add a placeholder for a spec
  * Include SecureRandom just cuz
  * Double the length of the guid to the more appropriate 32 characters
  * Add format validation to make sure that the value is only composed of hex
    characters
  * Switch from using 'reference_number' as the field name to 'guid'

Version v0.0.1 - January 11, 2013
================================================================================

  * Move the ReferenceNumber code from the project
  * Initial commit

