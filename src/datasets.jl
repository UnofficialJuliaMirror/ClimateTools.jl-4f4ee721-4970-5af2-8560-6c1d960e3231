

function dataset(file::String, vari::String)
    ds = Dataset(file)
    dsvar = ds[vari]
    timevec = ds["time"][:]
    lon = nomissing(ds["lon"][:], NaN)
    lat = nomissing(ds["lat"][:], NaN)

    varattrib = ds[vari].attrib
    globalattrib = ds.attrib

    A = AxisArray(dsvar, Axis{:lon}(lon), Axis{:lat}(lat), Axis{:time}(timevec))

    return ClimDataset(A, varattrib, globalattrib)
end

function processdata(C::ClimDataset)

    ds = Dataset("filename.nc","c")
# Dimensions

ds.dim["time"] = Inf # unlimited dimension
ds.dim["lat"] = 64
ds.dim["lon"] = 128
ds.dim["bnds"] = 2

# Declare variables

nctime = defVar(ds,"time", Float64, ("time",))
nctime.attrib["bounds"] = "time_bnds"
nctime.attrib["units"] = "days since 1850-1-1"
nctime.attrib["calendar"] = "365_day"
nctime.attrib["axis"] = "T"
nctime.attrib["long_name"] = "time"
nctime.attrib["standard_name"] = "time"

nctime_bnds = defVar(ds,"time_bnds", Float64, ("bnds", "time"))

nclat = defVar(ds,"lat", Float64, ("lat",))
nclat.attrib["bounds"] = "lat_bnds"
nclat.attrib["units"] = "degrees_north"
nclat.attrib["axis"] = "Y"
nclat.attrib["long_name"] = "latitude"
nclat.attrib["standard_name"] = "latitude"

nclat_bnds = defVar(ds,"lat_bnds", Float64, ("bnds", "lat"))

nclon = defVar(ds,"lon", Float64, ("lon",))
nclon.attrib["bounds"] = "lon_bnds"
nclon.attrib["units"] = "degrees_east"
nclon.attrib["axis"] = "X"
nclon.attrib["long_name"] = "longitude"
nclon.attrib["standard_name"] = "longitude"

nclon_bnds = defVar(ds,"lon_bnds", Float64, ("bnds", "lon"))

ncheight = defVar(ds,"height", Float64, ())
ncheight.attrib["units"] = "m"
ncheight.attrib["axis"] = "Z"
ncheight.attrib["positive"] = "up"
ncheight.attrib["long_name"] = "height"
ncheight.attrib["standard_name"] = "height"

nctasmax = defVar(ds,"tasmax", Float32, ("lon", "lat", "time"))
nctasmax.attrib["standard_name"] = "air_temperature"
nctasmax.attrib["long_name"] = "Daily Maximum Near-Surface Air Temperature"
nctasmax.attrib["units"] = "K"
nctasmax.attrib["original_name"] = "STMX"
nctasmax.attrib["cell_methods"] = "time: maximum (interval: 15 minutes)"
nctasmax.attrib["cell_measures"] = "area: areacella"
nctasmax.attrib["history"] = "2011-04-08T05:35:06Z altered by CMOR: Treated scalar dimension: 'height'. 2011-04-08T05:35:06Z altered by CMOR: replaced missing value flag (1e+38) with standard missing value (1e+20)."
nctasmax.attrib["coordinates"] = "height"
nctasmax.attrib["missing_value"] = Float32(1.0e20)
nctasmax.attrib["_FillValue"] = Float32(1.0e20)
nctasmax.attrib["associated_files"] = "baseURL: http://cmip-pcmdi.llnl.gov/CMIP5/dataLocation gridspecFile: gridspec_atmos_fx_CanESM2_rcp45_r0i0p0.nc areacella: areacella_fx_CanESM2_rcp45_r0i0p0.nc"

# Global attributes

ds.attrib["institution"] = "CCCma (Canadian Centre for Climate Modelling and Analysis, Victoria, BC, Canada)"
ds.attrib["institute_id"] = "CCCma"
ds.attrib["experiment_id"] = "rcp45"
ds.attrib["source"] = "CanESM2 2010 atmosphere: CanAM4 (AGCM15i, T63L35) ocean: CanOM4 (OGCM4.0, 256x192L40) and CMOC1.2 sea ice: CanSIM1 (Cavitating Fluid, T63 Gaussian Grid) land: CLASS2.7 and CTEM1"
ds.attrib["model_id"] = "CanESM2"
ds.attrib["forcing"] = "GHG,Oz,SA,BC,OC,LU,Sl (GHG includes CO2,CH4,N2O,CFC11,effective CFC12. Sl is the repeat of the 23rd solar cycle, years 1997-2008, after year 2008.)"
ds.attrib["parent_experiment_id"] = "historical"
ds.attrib["parent_experiment_rip"] = "r1i1p1"
ds.attrib["branch_time"] = 56940.0
ds.attrib["contact"] = "cccma_info@ec.gc.ca"
ds.attrib["references"] = "http://www.cccma.ec.gc.ca/models"
ds.attrib["initialization_method"] = 1
ds.attrib["physics_version"] = 1
ds.attrib["tracking_id"] = "57a1401a-eb5a-411d-81dc-65bbb3cce59b"
ds.attrib["branch_time_YMDH"] = "2006:01:01:00"
ds.attrib["CCCma_runid"] = "ICA"
ds.attrib["CCCma_parent_runid"] = "IGM"
ds.attrib["CCCma_data_licence"] = "1) GRANT OF LICENCE - The Government of Canada (Environment Canada) is the
owner of all intellectual property rights (including copyright) that may exist in this Data
product. You (as \"The Licensee\") are hereby granted a non-exclusive, non-assignable,
non-transferable unrestricted licence to use this data product for any purpose including
the right to share these data with others and to make value-added and derivative
products from it. This licence is not a sale of any or all of the owner's rights.
2) NO WARRANTY - This Data product is provided \"as-is\"; it has not been designed or
prepared to meet the Licensee's particular requirements. Environment Canada makes no
warranty, either express or implied, including but not limited to, warranties of
merchantability and fitness for a particular purpose. In no event will Environment Canada
be liable for any indirect, special, consequential or other damages attributed to the
Licensee's use of the Data product."
ds.attrib["product"] = "output"
ds.attrib["experiment"] = "RCP4.5"
ds.attrib["frequency"] = "day"
ds.attrib["creation_date"] = "2011-04-08T05:35:06Z"
ds.attrib["history"] = "2011-04-08T05:35:06Z CMOR rewrote data to comply with CF standards and CMIP5 requirements."
ds.attrib["Conventions"] = "CF-1.4"
ds.attrib["project_id"] = "CMIP5"
ds.attrib["table_id"] = "Table day (28 March 2011) f9d6cfec5981bb8be1801b35a81002f0"
ds.attrib["title"] = "CanESM2 model output prepared for CMIP5 RCP4.5"
ds.attrib["parent_experiment"] = "historical"
ds.attrib["modeling_realm"] = "atmos"
ds.attrib["realization"] = 1
ds.attrib["cmor_version"] = "2.5.4"

# Define variables

# nctime[:] = ...
# nctime_bnds[:] = ...
# nclat[:] = ...
# nclat_bnds[:] = ...
# nclon[:] = ...
# nclon_bnds[:] = ...
# ncheight[:] = ...
# nctasmax[:] = ...

close(ds)



    for i = 1:size(C.data.data, 1)
        for j = 1:size(C.data.data, 2)
            datavec = C.data.data[i, j, :] .+ rand(1)
        end
    end

end

function writedata(datavec, i, k)

    ds = Dataset("filename.nc", "a")

    # Append datavec

    close(ds)



end
