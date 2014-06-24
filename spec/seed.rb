#!/usr/bin/env ruby
$:.unshift(File.expand_path("../lib", File.dirname(__FILE__)))
require "dawn/api"
require "yaml"

@seed_log = File.open("seedlog.log", "w")
@seed_log.sync = true
Dawn.log = @seed_log

@ref = YAML.load_file("references/data.yml") rescue {}

def reference(obj)
  case obj
  when Dawn::App
    (@ref["apps"]||={})[obj.name] = obj.id
  when Dawn::Domain
    (@ref["domains"]||={})[obj.url] = obj.id
  when Dawn::Drain
    (@ref["drains"]||={})[obj.url] = obj.id
  when Dawn::Gear
    gears = (@ref["gears"]||={})
    gears[gears.size] = obj.id
  when Dawn::Release
    releases = (@ref["releases"]||={})
    releases[releases.size] = obj.id
  end
  p obj
end

if account = Dawn::Account.safe(:current)
  reference account.safe(:update, account: { username: "IceDragon" })
end
Dawn.authenticate(username: "IceDragon", password: "creampuff")

reference Dawn::App.safe(:create, app: { name: "app-test" })

reference Dawn::App.safe(:create, app: { name: "domains-test" })
reference Dawn::App.safe(:create, app: { name: "domain-test" })
if app = Dawn::App.safe(:find, name: "domain-test")
  reference app.domains.safe(:create, domain: { url: "cc-rushers.io" })
  reference app.domains.safe(:create, domain: { url: "cookiecrushers.com" })
  reference app.domains.safe(:create, domain: { url: "cookie-crusher.net" })
end

reference Dawn::App.safe(:create, app: { name: "drains-test" })
reference Dawn::App.safe(:create, app: { name: "drain-test" })
if app = Dawn::App.safe(:find, name: "drain-test")
  reference app.drains.safe(:create, drain: { url: "flushme.io" })
  reference app.drains.safe(:create, drain: { url: "toil.com" })
  reference app.drains.safe(:create, drain: { url: "downthedrain.net" })
end

reference Dawn::App.safe(:create, app: { name: "gears-test" })
reference Dawn::App.safe(:create, app: { name: "gear-test" })
if app = Dawn::App.find(name: "gear-test")
  #reference app.gears.safe(:create)
end

reference Dawn::App.safe(:create, app: { name: "releases-test" })
reference Dawn::App.safe(:create, app: { name: "release-test" })
if app = Dawn::App.find(name: "release-test")
  reference app.releases.safe(:create, {})
end

reference Dawn::App.safe(:create, app: { name: "env-test" })
if app = Dawn::App.find(name: "env-test")
  app.env.update({ "HOSTNAME" => "cookiesncode.io", "BREAD"=>"wheat" }).safe(:save)
end

File.write("references/data.yml", @ref.to_yaml)
