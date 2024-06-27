Logger.put_module_level(:ssl_alert, :error)

client_id = "3a105696-f440-4322-af76-56b0d025f0fd"
[tenant | _] = Defdo.MyApp.MyMvno.Resource.Tenant |> Ash.read!(authorize?: false)

{:ok, actor} = Defdo.MyApp.MyMvno.Actor |> Ash.Query.for_read(:by_client_id, client_id: client_id) |> Ash.read_one(tenant: tenant)
IO.inspect("-------------------------------------------------------------")
