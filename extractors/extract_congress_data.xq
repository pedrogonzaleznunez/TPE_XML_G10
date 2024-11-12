declare variable $congress_members_info external;
declare variable $congress_info external;
declare variable $congress_data_schema external;

declare function local:normalize($value) {
  if (normalize-space(string($value)) != "") then normalize-space(string($value)) else $value
};

declare function local:generate-xml($congress_members_info as document-node(), $congress_info as document-node()) as element(data) {
  element data {
    attribute xsi:noNamespaceSchemaLocation {$congress_data_schema},
    element congress {
      element name { local:normalize($congress_info//congress/name) },
      element period {
        attribute from { local:normalize($congress_info//congress/startYear) },
        attribute to { local:normalize($congress_info//congress/endYear) }
      },
      element url { local:normalize($congress_info//congress/url) },
      element chambers {
        for $chamber_name in distinct-values($congress_info//sessions/item/chamber)
        return element chamber {
          element name { local:normalize($chamber_name) },
          element members {
  let $chamber_members := $congress_members_info//members/member[
    for $member in . 
    for $term in $member/terms/item/item[local:normalize(chamber) = local:normalize($chamber_name)]
    return $member
  ]
  return 
    if (empty($chamber_members)) then
      element member {
        element name { '(void)' },
        element state { '(void)' },
        element party { '(void)' },
        element image_url { 'placeholder.jpg' },
        element period {
          attribute from { '(void)' },
          attribute to { '(void)' }
        }
      }
    else
      for $member in $chamber_members
      for $term in $member/terms/item/item[local:normalize(chamber) = local:normalize($chamber_name)]
      return element member {
        element name { local:normalize($member/name) },
        element state { local:normalize($member/state) },
        element party { local:normalize($member/partyName) },
        element image_url { local:normalize($member/depiction/imageUrl) },
        element period {
          attribute from { local:normalize($term/startYear) },
          attribute to { local:normalize($term/endYear) }
        }
      }
},

          element sessions {
            for $session in $congress_info//sessions/item[chamber = $chamber_name]
            return element session {
              element number {
                if (empty($session/number)) then -1 else local:normalize(number($session/number))
              },
              element period {
                attribute from { local:normalize($session/startDate) },
                attribute to { local:normalize($session/endDate) }
              },
              element type { local:normalize($session/type) }
            }
          }
        }
      }
    }
  }
};

let $congress_members_info_doc := doc($congress_members_info),
    $congress_info_doc := doc($congress_info)

return local:generate-xml($congress_members_info_doc, $congress_info_doc)
