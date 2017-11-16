/* eslint no-console:0 */

// Support component names relative to this directory:
var componentRequireContext = require.context("components", true)
import ReactRailsUJS from "react_ujs"
ReactRailsUJS.useContext(componentRequireContext)
