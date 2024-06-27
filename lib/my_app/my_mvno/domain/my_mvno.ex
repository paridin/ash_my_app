defmodule Defdo.MyApp.Domain.MyMvno do
  use Ash.Domain, extensions: [AshJsonApi.Domain]

  resources do
    resource Defdo.MyApp.MyMvno.Actor
    resource Defdo.MyApp.MyMvno.Resource.Tenant
    resource Defdo.MyApp.MyMvno.Resource.Package
    resource Defdo.MyApp.MyMvno.Resource.Theme
  end

  authorization do
    # require_actor? true
    authorize :by_default
  end

  json_api do
    prefix "/my-mvno/api"
    log_errors? false

    open_api do
      tag "Mvno Packages"
      group_by :domain
    end

    routes do
      # in the domain `base_route` acts like a scope
      base_route "/packages", Defdo.MyApp.MyMvno.Resource.Package do
        index :read
      end

      base_route "/theme", Defdo.MyApp.MyMvno.Resource.Theme do
        index :read
      end
    end
  end
end
