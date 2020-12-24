# coding: utf-8

require 'rack'

module DocodocoJpSpec
  module Test
    class Server
      def call(env)
        @root = File.expand_path(File.dirname(__FILE__))
        path = Rack::Utils.unescape(env['PATH_INFO'])
        _file = @root + "#{path}"

        params = Rack::Utils.parse_nested_query(env['QUERY_STRING'])

        return response_body__invalid_key(params) unless params["key1"] == "xxxxx" && params["key2"] == "yyyyy"
        response = case path
                   when "/v4/user_info"
                     response_body__user_info(params)
                   when "/v4/search"
                     response_body__search(params)
                   else
                     [404, {"Content-Type" => "text/plain"} , ["NOT FOUND"]]
                   end

        return response
      end

      private
      def response_body__search(params)
        body = <<-BODY
{
  "IP":"210.251.250.30",
  "CountryCode":"JP",
  "CountryAName":"japan",
  "CountryJName":"日本",
  "PrefCode":"22",
  "PrefAName":"shizuoka",
  "PrefJName":"静岡",
  "PrefLatitude":"34.97682",
  "PrefLongitude":"138.38315",
  "PrefCF":"00",
  "CityCode":"22206",
  "CityAName":"mishima-shi",
  "CityJName":"三島市",
  "CityLatitude":"35.11772",
  "CityLongitude":"138.91868",
  "CityCF":"00",
  "BCFlag":"b",
  "OrgCode":"100002637",
  "OrgOfficeCode":"0",
  "OrgIndependentCode":"0",
  "OrgName":"サイバーエリアリサーチ株式会社",
  "OrgPrefCode":"22",
  "OrgCityCode":"22206",
  "OrgZipCode":"411-0036",
  "OrgAddress":"静岡県三島市一番町18-22　アーサーファーストビル4F",
  "OrgTel":"055-991-5544",
  "OrgFax":"055-991-5540",
  "OrgIpoType":"9",
  "OrgDate":"200002",
  "OrgCapitalCode":"4",
  "OrgEmployeesCode":"3",
  "OrgGrossCode":"2",
  "OrgPresident":"山本　敬介",
  "OrgIndustrialCategoryL":"G",
  "OrgIndustrialCategoryM":"37,39,40",
  "OrgIndustrialCategoryS":"373,391,392,401",
  "OrgIndustrialCategoryT":"3731,3911,3921,3929,4013",
  "OrgDomainName":"arearesearch.co.jp",
  "OrgUrl":"http://www.arearesearch.co.jp/",
  "OrgLatitude":"35.1246742",
  "OrgLongitude":"138.9101771",
  "LineCode":"f",
  "LineJName":"フレッツISDN",
  "LineCF":"95",
  "ProxyFlag":"0",
  "TelCode":"059",
  "DomainName":"arearesearch.co.jp",
  "ContinentCode":"3",
  "RegionCode":"03",
  "OrgDomainType":".co.jp",
  "TimeZone":"+0900",
  "StockTickerNumber":"",
  "DomainType":".co.jp"
}
        BODY
        return [ 200, {"Content-Type" => 'text/javascript; charset="UTF-8'}, [body] ]
      end

      def response_body__user_info(params)
        body=<<-BODY
<?xml version="1.0" encoding="UTF-8"?>
<docodoco>
    <user_status>201</user_status>
    <user_status_message>Commercial Use</user_status_message>
</docodoco>
        BODY

        return [ 200, {"Content-Type" => 'application/xml; charset="UTF-8"'}, [body]]
      end

      def response_body__invalid_key(params)
        body=<<-BODY
<?xml version="1.0" encoding="UTF-8"?>
<docodoco>
    <user_status>401</user_status>
    <user_status_message>Unauthorized</user_status_message>
</docodoco>
        BODY

        return [ 200, {"Content-Type" => 'application/xml; charset="UTF-8"'}, [body]]
      end

    end
  end
end


