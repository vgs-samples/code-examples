load("@stdlib//base64", base64="base64")
load("@stdlib//binascii", binascii="binascii")
load("@stdlib//builtins", builtins="builtins")
load("@stdlib//json", json="json")
load("@stdlib//larky", larky="larky")
load("@stdlib//unittest", unittest="unittest")
load("@vendor//asserts", asserts="asserts")
load("@vgs//vault", vault="vault")
load("@stdlib//xml/etree/ElementTree", ElementTree="ElementTree")
load("@vendor//elementtree/SimpleXMLTreeBuilder", SimpleXMLTreeBuilder="SimpleXMLTreeBuilder")
load("@stdlib//io/StringIO", "StringIO")
load("@vgs//http/request", "VGSHttpRequest")


body = b'''<?xml version="1.0" encoding="unicode"?>
<soap:Envelope xmlns:ns3="http://tempuri.org/YSI.Interfaces.WebServices/ItfResidentData" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
   <soap:Body>
      <ns3:GetResidentDataResponse>
         <ns3:GetResidentDataResult>
            <MITS-ResidentData>
               <Summary>
                  <GenerationTimeStamp>2023-10-04T09:10:59</GenerationTimeStamp>
                  <SourceOrganization>Test Systems, Inc.</SourceOrganization>
                  <TotalLeaseFiles>1</TotalLeaseFiles>
                  <TotalTenants>1</TotalTenants>
               </Summary>
               <LeaseFiles>
                  <LeaseFile>
                     <Identification IDValue="a0000001" IDType="Test" />
                     <Property>
                        <Identification IDValue="testpay1" />
                        <MarketingName>Monthly Payments Test Property 1</MarketingName>
                        <LegalName>Monthly Payments Test Property 1</LegalName>
                        <Address AddressType="property">
                           <AddressLine1>Street 1</AddressLine1>
                           <City>City</City>
                           <State>CA</State>
                           <PostalCode>11111</PostalCode>
                           <Country>United States</Country>
                        </Address>
                     </Property>
                     <Unit>
                        <Identification IDValue="001" />
                        <UnitType>00001</UnitType>
                        <UnitTypeDescription>1 Bedroom 1 Bath</UnitTypeDescription>
                        <UnitTypeRent>001</UnitTypeRent>
                        <UnitTypeSquareFeet>0001</UnitTypeSquareFeet>
                        <UnitBedrooms>1</UnitBedrooms>
                        <UnitBathrooms>1.000000</UnitBathrooms>
                        <SquareFootType>internal</SquareFootType>
                        <UnitRent>1000.00</UnitRent>
                        <UnitSquareFeet>1000</UnitSquareFeet>
                        <UnitEconomicStatus>Residential</UnitEconomicStatus>
                        <UnitOccupancyStatus>occupied</UnitOccupancyStatus>
                        <UnitLeasedStatus>leased</UnitLeasedStatus>
                        <Address AddressType="mailing">
                           <Description>Unit</Description>
                           <AddressLine1>Address 1</AddressLine1>
                           <City>City</City>
                           <PostalCode>11111</PostalCode>
                           <Country>United States</Country>
                        </Address>
                     </Unit>
                     <MoveInDate>2023-07-05</MoveInDate>
                     <MoveOutDate>2023-07-05</MoveOutDate>
                     <NoticeDate>2023-07-05</NoticeDate>
                     <LeaseBegin>2023-07-05</LeaseBegin>
                     <LeaseEnd>2024-07-04</LeaseEnd>
                     <MonthlyRentAmount>1000</MonthlyRentAmount>
                     <DueDay>1</DueDay>
                     <Tenants>
                        <Identification IDValue="000001" IDType="Past" />
                        <Identification IDValue="0" IDType="Deposit Paid" OrganizationName="Deposit" />
                        <Identification IDValue="700.00" IDType="Deposit Charged" OrganizationName="Deposit" />
                        <PersonDetails>
                           <Name>
                              <FirstName>FirstName</FirstName>
                              <LastName>LastName</LastName>
                           </Name>
                           <Address AddressType="current">
                              <Description>Resident</Description>
                              <AddressLine1>Address 1</AddressLine1>
                              <City>City 1</City>
                              <PostalCode>11111</PostalCode>
                              <Country>United States</Country>
                           </Address>
                           <Phone PhoneType="cell">
                              <PhoneDescription>Mobile</PhoneDescription>
                              <PhoneNumber>0987654321</PhoneNumber>
                           </Phone>
                           <Email>test@domain.com</Email>
                        </PersonDetails>
                        <MoveInDate>2023-07-05</MoveInDate>
                        <MoveOutDate>2023-07-05</MoveOutDate>
                        <DateOfBirth>2005-07-01</DateOfBirth>
                        <SSN>123-45-6789</SSN>
                        <Vehicle />
                        <Vehicle />
                        <Vehicle />
                        <Vehicle />
                        <Employer />
                     </Tenants>
                     <LeaseCharges>
                        <LeaseCharge>
                           <ChargeCode>rent1</ChargeCode>
                           <ChargeCodeDescription>Base Rent</ChargeCodeDescription>
                           <Amount>1000.00</Amount>
                           <StartDate>2023-07-05</StartDate>
                        </LeaseCharge>
                        <LeaseCharge>
                           <ChargeCode>trash</ChargeCode>
                           <ChargeCodeDescription>Trash pick-up</ChargeCodeDescription>
                           <Amount>33.00</Amount>
                           <StartDate>2023-07-05</StartDate>
                        </LeaseCharge>
                     </LeaseCharges>
                     <CustomRecords>
                        <Record Field="Custom" Name="Lease Description" Value="None" />
                     </CustomRecords>
                  </LeaseFile>
               </LeaseFiles>
            </MITS-ResidentData>
         </ns3:GetResidentDataResult>
      </ns3:GetResidentDataResponse>
   </soap:Body>
</soap:Envelope>'''

expected_body = b'''<?xml version="1.0" encoding="unicode"?>
<soap:Envelope xmlns:ns3="http://tempuri.org/YSI.Interfaces.WebServices/ItfResidentData" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
   <soap:Body>
      <ns3:GetResidentDataResponse>
         <ns3:GetResidentDataResult>
            <MITS-ResidentData>
               <Summary>
                  <GenerationTimeStamp>2023-10-04T09:10:59</GenerationTimeStamp>
                  <SourceOrganization>Test Systems, Inc.</SourceOrganization>
                  <TotalLeaseFiles>1</TotalLeaseFiles>
                  <TotalTenants>1</TotalTenants>
               </Summary>
               <LeaseFiles>
                  <LeaseFile>
                     <Identification IDValue="a0000001" IDType="Test" />
                     <Property>
                        <Identification IDValue="testpay1" />
                        <MarketingName>Monthly Payments Test Property 1</MarketingName>
                        <LegalName>Monthly Payments Test Property 1</LegalName>
                        <Address AddressType="property">
                           <AddressLine1>Street 1</AddressLine1>
                           <City>City</City>
                           <State>CA</State>
                           <PostalCode>11111</PostalCode>
                           <Country>United States</Country>
                        </Address>
                     </Property>
                     <Unit>
                        <Identification IDValue="001" />
                        <UnitType>00001</UnitType>
                        <UnitTypeDescription>1 Bedroom 1 Bath</UnitTypeDescription>
                        <UnitTypeRent>001</UnitTypeRent>
                        <UnitTypeSquareFeet>0001</UnitTypeSquareFeet>
                        <UnitBedrooms>1</UnitBedrooms>
                        <UnitBathrooms>1.000000</UnitBathrooms>
                        <SquareFootType>internal</SquareFootType>
                        <UnitRent>1000.00</UnitRent>
                        <UnitSquareFeet>1000</UnitSquareFeet>
                        <UnitEconomicStatus>Residential</UnitEconomicStatus>
                        <UnitOccupancyStatus>occupied</UnitOccupancyStatus>
                        <UnitLeasedStatus>leased</UnitLeasedStatus>
                        <Address AddressType="mailing">
                           <Description>Unit</Description>
                           <AddressLine1>Address 1</AddressLine1>
                           <City>City</City>
                           <PostalCode>11111</PostalCode>
                           <Country>United States</Country>
                        </Address>
                     </Unit>
                     <MoveInDate>2023-07-05</MoveInDate>
                     <MoveOutDate>2023-07-05</MoveOutDate>
                     <NoticeDate>2023-07-05</NoticeDate>
                     <LeaseBegin>2023-07-05</LeaseBegin>
                     <LeaseEnd>2024-07-04</LeaseEnd>
                     <MonthlyRentAmount>1000</MonthlyRentAmount>
                     <DueDay>1</DueDay>
                     <Tenants>
                        <Identification IDValue="000001" IDType="Past" />
                        <Identification IDValue="0" IDType="Deposit Paid" OrganizationName="Deposit" />
                        <Identification IDValue="700.00" IDType="Deposit Charged" OrganizationName="Deposit" />
                        <PersonDetails>
                           <Name>
                              <FirstName>FirstName</FirstName>
                              <LastName>LastName</LastName>
                           </Name>
                           <Address AddressType="current">
                              <Description>Resident</Description>
                              <AddressLine1>Address 1</AddressLine1>
                              <City>City 1</City>
                              <PostalCode>11111</PostalCode>
                              <Country>United States</Country>
                           </Address>
                           <Phone PhoneType="cell">
                              <PhoneDescription>Mobile</PhoneDescription>
                              <PhoneNumber>0987654321</PhoneNumber>
                           </Phone>
                           <Email>test@domain.com</Email>
                        </PersonDetails>
                        <MoveInDate>2023-07-05</MoveInDate>
                        <MoveOutDate>2023-07-05</MoveOutDate>
                        <DateOfBirth>2005-07-01</DateOfBirth>
                        <SSN>tok_sandbox_wPAssM5SSCe4xPRM4j8Z6Q</SSN>
                        <Vehicle />
                        <Vehicle />
                        <Vehicle />
                        <Vehicle />
                        <Employer />
                     </Tenants>
                     <LeaseCharges>
                        <LeaseCharge>
                           <ChargeCode>rent1</ChargeCode>
                           <ChargeCodeDescription>Base Rent</ChargeCodeDescription>
                           <Amount>1000.00</Amount>
                           <StartDate>2023-07-05</StartDate>
                        </LeaseCharge>
                        <LeaseCharge>
                           <ChargeCode>trash</ChargeCode>
                           <ChargeCodeDescription>Trash pick-up</ChargeCodeDescription>
                           <Amount>33.00</Amount>
                           <StartDate>2023-07-05</StartDate>
                        </LeaseCharge>
                     </LeaseCharges>
                     <CustomRecords>
                        <Record Field="Custom" Name="Lease Description" Value="None" />
                     </CustomRecords>
                  </LeaseFile>
               </LeaseFiles>
            </MITS-ResidentData>
         </ns3:GetResidentDataResult>
      </ns3:GetResidentDataResponse>
   </soap:Body>
</soap:Envelope>'''


vault = {
   "123-45-6789": "tok_sandbox_wPAssM5SSCe4xPRM4j8Z6Q"
}


def process(input, ctx):
    root = ElementTree.fromstring(str(input.body))
    ssn_element = root.find(".//SSN")
    ssn = ssn_element.text
    ssn_alias = vault.get(ssn)
    ssn_element.text = ssn_alias
    input.body = ElementTree.tostring(root, encoding="unicode")
    return input


def test_process():
    input = VGSHttpRequest("https://VAULT_ID.sandbox.verygoodproxy.com/post", data=body, headers={}, method='POST')
    response = process(input, None)
    #print(response.body)
    #print(expected_body)
    asserts.assert_that(response.body).is_equal_to(str(expected_body))

def _testsuite():
  _suite = unittest.TestSuite()
  _suite.addTest(unittest.FunctionTestCase(test_process))
  return _suite

_runner = unittest.TextTestRunner()
_runner.run(_testsuite())


















