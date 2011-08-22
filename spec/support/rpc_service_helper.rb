module RPCServiceHelper
  def service(name, &block)
    context "'#{name}'" do
      define_method :fixture_name do
        suffix = self.class.fixture_suffix.gsub(/\s/, '_')
        if suffix.length > 0
          "#{name}_#{suffix}"
        else
          name
        end
      end
      
      define_method :result do |*args|
        FakeWeb.register_uri(:post, "http://user:pass@localhost:8332", :response => fixture(fixture_name))
        subject.send(name, *args)
      end
      
      class << self
        def fixture_suffix
          @fixture_suffix ||= ""
        end
        
        def context(desc, &block)
          super desc do
            fixture_suffix.concat desc
            instance_eval &block
          end
        end
      end

      instance_eval &block
    end
  end
end
