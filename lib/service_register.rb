# Register repositories
class ServiceRegister
  def self.register(type, repo)
    service[type] = repo
  end

  def self.service
    @services ||= {}
  end

  def self.for(type)
    service[type]
  end
end
# https://8thlight.com/blog/mike-ebert/2013/03/23/the-repository-pattern.html

class Repository < ServiceRegister; end
class Service < ServiceRegister; end
class Report < ServiceRegister; end
