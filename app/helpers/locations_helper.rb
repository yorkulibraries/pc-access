module LocationsHelper
  def parse_subnets(subnets)
    if subnets != nil
      return subnets.split( /\r?\n/ )
    end
  end
end
