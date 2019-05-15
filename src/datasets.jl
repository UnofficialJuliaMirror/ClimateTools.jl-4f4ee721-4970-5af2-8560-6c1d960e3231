

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
