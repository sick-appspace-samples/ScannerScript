--[[----------------------------------------------------------------------------

  Application Name: ScannerScript

  Description:
  Retrieving scans from remote device and view as point cloud using Lua script.

  This sample retrieves scan data from a connected scanner device. To run this
  sample, the IP address in the script has to match the device.
  Scans can be viewed in the PointCloud gViewer on the webpage.

------------------------------------------------------------------------------]]
--Start of Global Scope---------------------------------------------------------

-- luacheck: globals gScanProvider gViewer gTransformer gHandleOnNewScan

-- Provide scans from device
gScanProvider = Scan.Provider.RemoteScanner.create()
Scan.Provider.RemoteScanner.setIPAddress(gScanProvider, '192.168.0.1')
-- Register callback, starts providing automatically
Scan.Provider.RemoteScanner.register( gScanProvider, 'OnNewScan', 'gHandleOnNewScan' )
-- Create a viewer instance
gViewer = View.create('viewer3D1')

-----------------------------------------------------------------------------------------------
-- Create a transform instance to convert the Scan to a PointCloud
gTransformer = Scan.Transform.create()

--End of Global Scope-----------------------------------------------------------

--Start of Function and Event Scope---------------------------------------------

---Callback function to process new scans
function gHandleOnNewScan(scan)
  -- View the scan on the Scan viewer on the webpage.
  View.view(gViewer, scan)
  -- Transform to PointCloud to view in the PointCloud viewer on the webpage
  local pointCloud = Scan.Transform.transformToPointCloud(gTransformer, scan)
  View.view(gViewer, pointCloud)
end

--End of Function and Event Scope------------------------------------------------
