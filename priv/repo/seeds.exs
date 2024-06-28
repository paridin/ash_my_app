# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     MyApp.Repo.insert!(%MyApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

client_id = "3a105696-f440-4322-af76-56b0d025f0fd"
mvno_id = 4

tenant = Defdo.MyApp.MyMvno.Resource.Tenant
|> Ash.Changeset.for_create(:create, %{name: "test"})
|> Ash.create!(authorize?: false)
|> IO.inspect()

actor = Defdo.MyApp.MyMvno.Actor
|> Ash.Changeset.for_create(:create, %{code: "defdo", type: "mvno", mvno_profile_id: mvno_id, name: "example actor", auth_method: "client_credentials", code: "defdo", app_type: "api", allowed_domains: ["https://localhost:4003/"], client_id: client_id})
|> Ash.create!(tenant: tenant)

package = Defdo.MyApp.MyMvno.Resource.Package
|> Ash.Changeset.for_create(:create, %{name: "example package", mvno_id: mvno_id})
|> Ash.create!(authorize?: false)

theme = Defdo.MyApp.MyMvno.Resource.Theme
|> Ash.Changeset.for_create(:create, %{code: "defdo", name: "basic theme"})
|> Ash.create!(tenant: tenant, authorize?: false)
