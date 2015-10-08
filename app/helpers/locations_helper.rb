module LocationsHelper
  def parse_subnets(subnets)
    if subnets != nil
      return subnets.split( /\r?\n/ )
    else
      return Array.new
    end
  end
end
