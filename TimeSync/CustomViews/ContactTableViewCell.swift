//
//  ContactTableViewCell.swift
//  TimeSync
//
//  Created by Lee Sangoroh on 25/08/2024.
//

import UIKit

protocol ContactTableViewCellDelegate: AnyObject {
    func didFetchCurrentTime(_ time: String)
}

class ContactTableViewCell: UITableViewCell {
    
    weak var delegate: ContactTableViewCellDelegate?
    var profilePhoto = UIImageView()
    var nameLabel = UILabel()
    var localTimeLabel = UILabel()
    var countryLabel = UILabel()
    var isWorkingStatus = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(named: "background_color")
        
        addSubview(profilePhoto)
        addSubview(nameLabel)
        addSubview(localTimeLabel)
        addSubview(countryLabel)
        addSubview(isWorkingStatus)
        
        configureImageView()
        configureIsWorkingStatus()
        configureNameLabel()
        configureCountryLabel()
        configureLocalTimeLabel()
        setViewConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(contact: Contact) {
        profilePhoto.image = UIImage(named: "empty-contact-image")
        nameLabel.text = contact.givenName
        
        guard let firstPhoneNumber = contact.phoneNumbers.first?.number else {
                print("No phone numbers available")
                return
            }
            
        // Extract the country code
        let countryCode = extractCountryCode(from: firstPhoneNumber)
            
        // Determine the country
        let country = getCountryFromCode(countryCode)
            
        // Get the current time in that country
        let currentTime = getCurrentTime(for: countryCode)
        // Notify the delegate with the current time
        delegate?.didFetchCurrentTime(currentTime)
        
        let isWithinWorkingHours: Bool = checkIfWithinWorkingHours(for: countryCode)
        
        
        localTimeLabel.text =  "\(currentTime) hrs"
        countryLabel.text = "\(country)"
        isWorkingStatus.backgroundColor = .systemRed
        //set isWorkingStatus
        if isWithinWorkingHours {
            isWorkingStatus.backgroundColor = .systemGreen
        } else {
            isWorkingStatus.backgroundColor = .systemRed
        }
            
    }
    
    
    func configureImageView(){
        profilePhoto.layer.cornerRadius = 30
        profilePhoto.clipsToBounds = true
    }
    
    
    func configureNameLabel() {
        nameLabel.numberOfLines = 0
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
    }
    
    
    func configureLocalTimeLabel() {
        localTimeLabel.numberOfLines = 1
        localTimeLabel.adjustsFontSizeToFitWidth = true
        localTimeLabel.textColor = .secondaryLabel
        localTimeLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    }
    
    
    func configureCountryLabel(){
        countryLabel.numberOfLines = 1
        countryLabel.adjustsFontSizeToFitWidth = true
        countryLabel.textColor = .secondaryLabel
        countryLabel.font = UIFont.systemFont(ofSize: 15)
    }
    
    func configureIsWorkingStatus() {
        isWorkingStatus.layer.cornerRadius = 5
    }
    
    func setViewConstraints() {
        profilePhoto.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        localTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        isWorkingStatus.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profilePhoto.topAnchor.constraint(equalTo: self.topAnchor, constant: 3),
            profilePhoto.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            profilePhoto.heightAnchor.constraint(equalToConstant: 60),
            profilePhoto.widthAnchor.constraint(equalToConstant: 60),
            
            isWorkingStatus.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            isWorkingStatus.widthAnchor.constraint(equalTo:profilePhoto.widthAnchor),
            isWorkingStatus.heightAnchor.constraint(equalToConstant: 10),
            isWorkingStatus.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: profilePhoto.trailingAnchor, constant: 10),
            
            countryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            countryLabel.heightAnchor.constraint(equalToConstant: 20),
            countryLabel.leadingAnchor.constraint(equalTo: profilePhoto.trailingAnchor, constant: 10),
            
            localTimeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            localTimeLabel.heightAnchor.constraint(equalToConstant: 20),
            localTimeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    
    func extractCountryCode(from phoneNumber: String) -> String {
        // Basic example using string prefix
        // Assuming country codes are at most 4 digits long
        let countryCodePrefixes = [
            "07", "+1", "+7", "+20", "+27", "+30", "+31", "+32", "+33", "+34", "+36", "+39", "+40", "+41", "+43", "+44", "+45", "+46", "+47", "+48", "+49",
            "+51", "+52", "+53", "+54", "+55", "+56", "+57", "+58", "+60", "+61", "+62", "+63", "+64", "+65", "+66", "+81", "+82", "+84", "+86",
            "+90", "+91", "+92", "+93", "+94", "+95", "+98", "+211", "+212", "+213", "+216", "+218", "+220", "+221", "+222", "+223", "+224", "+225",
            "+226", "+227", "+228", "+229", "+230", "+231", "+232", "+233", "+234", "+235", "+236", "+237", "+238", "+239", "+240", "+241", "+242",
            "+243", "+244", "+245", "+246", "+247", "+248", "+249", "+250", "+251", "+252", "+253", "+254", "+255", "+256", "+257", "+258", "+260",
            "+261", "+262", "+263", "+264", "+265", "+266", "+267", "+268", "+269", "+290", "+291", "+297", "+298", "+299", "+350", "+351", "+352",
            "+353", "+354", "+355", "+356", "+357", "+358", "+359", "+370", "+371", "+372", "+373", "+374", "+375", "+376", "+377", "+378", "+379",
            "+380", "+381", "+382", "+383", "+385", "+386", "+387", "+389", "+420", "+421", "+423", "+500", "+501", "+502", "+503", "+504", "+505",
            "+506", "+507", "+508", "+509", "+590", "+591", "+592", "+593", "+594", "+595", "+596", "+597", "+598", "+599", "+670", "+672", "+673",
            "+674", "+675", "+676", "+677", "+678", "+679", "+680", "+681", "+682", "+683", "+685", "+686", "+687", "+688", "+689", "+690", "+691",
            "+692", "+850", "+852", "+853", "+855", "+856", "+870", "+880", "+886", "+91", "+960", "+961", "+962", "+963", "+964", "+965", "+966", "+967",
            "+968", "+970", "+971", "+972", "+973", "+974", "+975", "+976", "+977", "+992", "+993", "+994", "+995", "+996", "+998"
        ]

        
        for prefix in countryCodePrefixes {
            if phoneNumber.hasPrefix(prefix) {
                return prefix
            }
        }
        return ""
    }

    func getCountryFromCode(_ countryCode: String) -> String {
        let countryCodes = [
            "07": "Kenya",
            "+1": "United States/Canada",
            "+7": "Russia/Kazakhstan",
            "+20": "Egypt",
            "+27": "South Africa",
            "+30": "Greece",
            "+31": "Netherlands",
            "+32": "Belgium",
            "+33": "France",
            "+34": "Spain",
            "+36": "Hungary",
            "+39": "Italy",
            "+40": "Romania",
            "+41": "Switzerland",
            "+43": "Austria",
            "+44": "United Kingdom",
            "+45": "Denmark",
            "+46": "Sweden",
            "+47": "Norway",
            "+48": "Poland",
            "+49": "Germany",
            "+51": "Peru",
            "+52": "Mexico",
            "+53": "Cuba",
            "+54": "Argentina",
            "+55": "Brazil",
            "+56": "Chile",
            "+57": "Colombia",
            "+58": "Venezuela",
            "+60": "Malaysia",
            "+61": "Australia",
            "+62": "Indonesia",
            "+63": "Philippines",
            "+64": "New Zealand",
            "+65": "Singapore",
            "+66": "Thailand",
            "+81": "Japan",
            "+82": "South Korea",
            "+84": "Vietnam",
            "+86": "China",
            "+90": "Turkey",
            "+91": "India",
            "+92": "Pakistan",
            "+93": "Afghanistan",
            "+94": "Sri Lanka",
            "+95": "Myanmar",
            "+98": "Iran",
            "+211": "South Sudan",
            "+212": "Morocco",
            "+213": "Algeria",
            "+216": "Tunisia",
            "+218": "Libya",
            "+220": "Gambia",
            "+221": "Senegal",
            "+222": "Mauritania",
            "+223": "Mali",
            "+224": "Guinea",
            "+225": "Ivory Coast",
            "+226": "Burkina Faso",
            "+227": "Niger",
            "+228": "Togo",
            "+229": "Benin",
            "+230": "Mauritius",
            "+231": "Liberia",
            "+232": "Sierra Leone",
            "+233": "Ghana",
            "+234": "Nigeria",
            "+235": "Chad",
            "+236": "Central African Republic",
            "+237": "Cameroon",
            "+238": "Cape Verde",
            "+239": "Sao Tome and Principe",
            "+240": "Equatorial Guinea",
            "+241": "Gabon",
            "+242": "Republic of the Congo",
            "+243": "Democratic Republic of the Congo",
            "+244": "Angola",
            "+245": "Guinea-Bissau",
            "+246": "Diego Garcia",
            "+247": "Ascension Island",
            "+248": "Seychelles",
            "+249": "Sudan",
            "+250": "Rwanda",
            "+251": "Ethiopia",
            "+252": "Somalia",
            "+253": "Djibouti",
            "+254": "Kenya",
            "+255": "Tanzania",
            "+256": "Uganda",
            "+257": "Burundi",
            "+258": "Mozambique",
            "+260": "Zambia",
            "+261": "Madagascar",
            "+262": "Réunion/Mayotte",
            "+263": "Zimbabwe",
            "+264": "Namibia",
            "+265": "Malawi",
            "+266": "Lesotho",
            "+267": "Botswana",
            "+268": "Eswatini",
            "+269": "Comoros",
            "+290": "Saint Helena",
            "+291": "Eritrea",
            "+297": "Aruba",
            "+298": "Faroe Islands",
            "+299": "Greenland",
            "+350": "Gibraltar",
            "+351": "Portugal",
            "+352": "Luxembourg",
            "+353": "Ireland",
            "+354": "Iceland",
            "+355": "Albania",
            "+356": "Malta",
            "+357": "Cyprus",
            "+358": "Finland",
            "+359": "Bulgaria",
            "+370": "Lithuania",
            "+371": "Latvia",
            "+372": "Estonia",
            "+373": "Moldova",
            "+374": "Armenia",
            "+375": "Belarus",
            "+376": "Andorra",
            "+377": "Monaco",
            "+378": "San Marino",
            "+379": "Vatican City",
            "+380": "Ukraine",
            "+381": "Serbia",
            "+382": "Montenegro",
            "+383": "Kosovo",
            "+385": "Croatia",
            "+386": "Slovenia",
            "+387": "Bosnia and Herzegovina",
            "+389": "North Macedonia",
            "+420": "Czech Republic",
            "+421": "Slovakia",
            "+423": "Liechtenstein",
            "+500": "Falkland Islands",
            "+501": "Belize",
            "+502": "Guatemala",
            "+503": "El Salvador",
            "+504": "Honduras",
            "+505": "Nicaragua",
            "+506": "Costa Rica",
            "+507": "Panama",
            "+508": "Saint Pierre and Miquelon",
            "+509": "Haiti",
            "+590": "Guadeloupe/Saint Martin/Saint Barthélemy",
            "+591": "Bolivia",
            "+592": "Guyana",
            "+593": "Ecuador",
            "+594": "French Guiana",
            "+595": "Paraguay",
            "+596": "Martinique",
            "+597": "Suriname",
            "+598": "Uruguay",
            "+599": "Curaçao/Bonaire",
            "+670": "East Timor",
            "+672": "Australian Antarctic Territory/Norfolk Island",
            "+673": "Brunei",
            "+674": "Nauru",
            "+675": "Papua New Guinea",
            "+676": "Tonga",
            "+677": "Solomon Islands",
            "+678": "Vanuatu",
            "+679": "Fiji",
            "+680": "Palau",
            "+681": "Wallis and Futuna",
            "+682": "Cook Islands",
            "+683": "Niue",
            "+685": "Samoa",
            "+686": "Kiribati",
            "+687": "New Caledonia",
            "+688": "Tuvalu",
            "+689": "French Polynesia",
            "+690": "Tokelau",
            "+691": "Federated States of Micronesia",
            "+692": "Marshall Islands",
            "+850": "North Korea",
            "+852": "Hong Kong",
            "+853": "Macau",
            "+855": "Cambodia",
            "+856": "Laos",
            "+870": "Inmarsat",
            "+880": "Bangladesh",
            "+886": "Taiwan",
            "+960": "Maldives",
            "+961": "Lebanon",
            "+962": "Jordan",
            "+963": "Syria",
            "+964": "Iraq",
            "+965": "Kuwait",
            "+966": "Saudi Arabia",
            "+967": "Yemen",
            "+968": "Oman",
            "+970": "Palestine",
            "+971": "United Arab Emirates",
            "+972": "Israel",
            "+973": "Bahrain",
            "+974": "Qatar",
            "+975": "Bhutan",
            "+976": "Mongolia",
            "+977": "Nepal",
            "+992": "Tajikistan",
            "+993": "Turkmenistan",
            "+994": "Azerbaijan",
            "+995": "Georgia",
            "+996": "Kyrgyzstan",
            "+998": "Uzbekistan"
        ]

        
        return countryCodes[countryCode] ?? "Unknown Country"
    }

    func getCurrentTime(for countryCode: String) -> String {
        let timeZoneIdentifiers = [
            "07": "Africa/Nairobi",
            "+1": "America/New_York",        // United States/Canada (Eastern Time)
            "+7": "Asia/Novosibirsk",        // Russia
            "+20": "Africa/Cairo",           // Egypt
            "+27": "Africa/Johannesburg",    // South Africa
            "+30": "Europe/Athens",          // Greece
            "+31": "Europe/Amsterdam",       // Netherlands
            "+32": "Europe/Brussels",        // Belgium
            "+33": "Europe/Paris",           // France
            "+34": "Europe/Madrid",          // Spain
            "+36": "Europe/Budapest",        // Hungary
            "+39": "Europe/Rome",            // Italy
            "+40": "Europe/Bucharest",       // Romania
            "+41": "Europe/Zurich",          // Switzerland
            "+43": "Europe/Vienna",          // Austria
            "+44": "Europe/London",          // United Kingdom
            "+45": "Europe/Copenhagen",      // Denmark
            "+46": "Europe/Stockholm",       // Sweden
            "+47": "Europe/Oslo",            // Norway
            "+48": "Europe/Warsaw",          // Poland
            "+49": "Europe/Berlin",          // Germany
            "+51": "America/Lima",           // Peru
            "+52": "America/Mexico_City",    // Mexico
            "+53": "America/Havana",         // Cuba
            "+54": "America/Argentina/Buenos_Aires", // Argentina
            "+55": "America/Sao_Paulo",      // Brazil
            "+56": "America/Santiago",       // Chile
            "+57": "America/Bogota",         // Colombia
            "+58": "America/Caracas",        // Venezuela
            "+60": "Asia/Kuala_Lumpur",      // Malaysia
            "+61": "Australia/Sydney",       // Australia
            "+62": "Asia/Jakarta",           // Indonesia
            "+63": "Asia/Manila",            // Philippines
            "+64": "Pacific/Auckland",       // New Zealand
            "+65": "Asia/Singapore",         // Singapore
            "+66": "Asia/Bangkok",           // Thailand
            "+81": "Asia/Tokyo",             // Japan
            "+82": "Asia/Seoul",             // South Korea
            "+84": "Asia/Ho_Chi_Minh",       // Vietnam
            "+86": "Asia/Shanghai",          // China
            "+90": "Europe/Istanbul",        // Turkey
            "+91": "Asia/Kolkata",           // India
            "+92": "Asia/Karachi",           // Pakistan
            "+93": "Asia/Kabul",             // Afghanistan
            "+94": "Asia/Colombo",           // Sri Lanka
            "+95": "Asia/Yangon",            // Myanmar
            "+98": "Asia/Tehran",            // Iran
            "+211": "Africa/Juba",           // South Sudan
            "+212": "Africa/Casablanca",     // Morocco
            "+213": "Africa/Algiers",        // Algeria
            "+216": "Africa/Tunis",          // Tunisia
            "+218": "Africa/Tripoli",        // Libya
            "+220": "Africa/Banjul",         // Gambia
            "+221": "Africa/Dakar",          // Senegal
            "+222": "Africa/Nouakchott",     // Mauritania
            "+223": "Africa/Bamako",         // Mali
            "+224": "Africa/Conakry",        // Guinea
            "+225": "Africa/Abidjan",        // Ivory Coast
            "+226": "Africa/Ouagadougou",    // Burkina Faso
            "+227": "Africa/Niamey",         // Niger
            "+228": "Africa/Lome",           // Togo
            "+229": "Africa/Porto-Novo",     // Benin
            "+230": "Indian/Mauritius",      // Mauritius
            "+231": "Africa/Monrovia",       // Liberia
            "+232": "Africa/Freetown",       // Sierra Leone
            "+233": "Africa/Accra",          // Ghana
            "+234": "Africa/Lagos",          // Nigeria
            "+235": "Africa/Ndjamena",       // Chad
            "+236": "Africa/Bangui",         // Central African Republic
            "+237": "Africa/Douala",         // Cameroon
            "+238": "Atlantic/Cape_Verde",   // Cape Verde
            "+239": "Africa/Sao_Tome",       // Sao Tome and Principe
            "+240": "Africa/Malabo",         // Equatorial Guinea
            "+241": "Africa/Libreville",     // Gabon
            "+242": "Africa/Brazzaville",    // Republic of the Congo
            "+243": "Africa/Kinshasa",       // Democratic Republic of the Congo
            "+244": "Africa/Luanda",         // Angola
            "+245": "Africa/Bissau",         // Guinea-Bissau
            "+246": "Indian/Chagos",         // Diego Garcia
            "+247": "Atlantic/Ascension",    // Ascension Island
            "+248": "Indian/Mahe",           // Seychelles
            "+249": "Africa/Khartoum",       // Sudan
            "+250": "Africa/Kigali",         // Rwanda
            "+251": "Africa/Addis_Ababa",    // Ethiopia
            "+252": "Africa/Mogadishu",      // Somalia
            "+253": "Africa/Djibouti",       // Djibouti
            "+254": "Africa/Nairobi",        // Kenya
            "+255": "Africa/Dar_es_Salaam",  // Tanzania
            "+256": "Africa/Kampala",        // Uganda
            "+257": "Africa/Bujumbura",      // Burundi
            "+258": "Africa/Maputo",         // Mozambique
            "+260": "Africa/Lusaka",         // Zambia
            "+261": "Indian/Antananarivo",   // Madagascar
            "+262": "Indian/Reunion",        // Réunion/Mayotte
            "+263": "Africa/Harare",         // Zimbabwe
            "+264": "Africa/Windhoek",       // Namibia
            "+265": "Africa/Blantyre",       // Malawi
            "+266": "Africa/Maseru",         // Lesotho
            "+267": "Africa/Gaborone",       // Botswana
            "+268": "Africa/Mbabane",        // Eswatini
            "+269": "Indian/Comoro",         // Comoros
            "+290": "Atlantic/St_Helena",    // Saint Helena
            "+291": "Africa/Asmara",         // Eritrea
            "+297": "America/Aruba",         // Aruba
            "+298": "Atlantic/Faroe",        // Faroe Islands
            "+299": "America/Godthab",       // Greenland
            "+350": "Europe/Gibraltar",      // Gibraltar
            "+351": "Europe/Lisbon",         // Portugal
            "+352": "Europe/Luxembourg",     // Luxembourg
            "+353": "Europe/Dublin",         // Ireland
            "+354": "Atlantic/Reykjavik",    // Iceland
            "+355": "Europe/Tirane",         // Albania
            "+356": "Europe/Malta",          // Malta
            "+357": "Asia/Nicosia",          // Cyprus
            "+358": "Europe/Helsinki",       // Finland
            "+359": "Europe/Sofia",          // Bulgaria
            "+370": "Europe/Vilnius",        // Lithuania
            "+371": "Europe/Riga",           // Latvia
            "+372": "Europe/Tallinn",        // Estonia
            "+373": "Europe/Chisinau",       // Moldova
            "+374": "Asia/Yerevan",          // Armenia
            "+375": "Europe/Minsk",          // Belarus
            "+376": "Europe/Andorra",        // Andorra
            "+377": "Europe/Monaco",         // Monaco
            "+378": "Europe/San_Marino",     // San Marino
            "+379": "Europe/Vatican",        // Vatican City
            "+380": "Europe/Kiev",           // Ukraine
            "+381": "Europe/Belgrade",       // Serbia
            "+382": "Europe/Podgorica",      // Montenegro
            "+383": "Europe/Pristina",       // Kosovo
            "+385": "Europe/Zagreb",         // Croatia
            "+386": "Europe/Ljubljana",      // Slovenia
            "+387": "Europe/Sarajevo",       // Bosnia and Herzegovina
            "+389": "Europe/Skopje",         // North Macedonia
            "+420": "Europe/Prague",         // Czech Republic
            "+421": "Europe/Bratislava",     // Slovakia
            "+423": "Europe/Vaduz",          // Liechtenstein
            "+500": "Atlantic/Stanley",      // Falkland Islands
            "+501": "America/Belize",        // Belize
            "+502": "America/Guatemala",     // Guatemala
            "+503": "America/El_Salvador",   // El Salvador
            "+504": "America/Tegucigalpa",   // Honduras
            "+505": "America/Managua",       // Nicaragua
            "+506": "America/Costa_Rica",    // Costa Rica
            "+507": "America/Panama",        // Panama
            "+508": "America/Miquelon",      // Saint Pierre and Miquelon
            "+509": "America/Port-au-Prince",// Haiti
            "+590": "America/Guadeloupe",    // Guadeloupe
            "+591": "America/La_Paz",        // Bolivia
            "+592": "America/Guyana",        // Guyana
            "+593": "America/Guayaquil",     // Ecuador
            "+594": "America/Cayenne",       // French Guiana
            "+595": "America/Asuncion",      // Paraguay
            "+596": "America/Martinique",    // Martinique
            "+597": "America/Paramaribo",    // Suriname
            "+598": "America/Montevideo",    // Uruguay
            "+599": "America/Curacao",       // Curaçao
            "+670": "Asia/Dili",             // East Timor
            "+672": "Antarctica/Macquarie",  // Australian External Territories
            "+673": "Asia/Brunei",           // Brunei
            "+674": "Pacific/Nauru",         // Nauru
            "+675": "Pacific/Port_Moresby",  // Papua New Guinea
            "+676": "Pacific/Tongatapu",     // Tonga
            "+677": "Pacific/Guadalcanal",   // Solomon Islands
            "+678": "Pacific/Efate",         // Vanuatu
            "+679": "Pacific/Fiji",          // Fiji
            "+680": "Pacific/Palau",         // Palau
            "+681": "Pacific/Wallis",        // Wallis and Futuna
            "+682": "Pacific/Rarotonga",     // Cook Islands
            "+683": "Pacific/Niue",          // Niue
            "+685": "Pacific/Apia",          // Samoa
            "+686": "Pacific/Tarawa",        // Kiribati
            "+687": "Pacific/Noumea",        // New Caledonia
            "+688": "Pacific/Funafuti",      // Tuvalu
            "+689": "Pacific/Tahiti",        // French Polynesia
            "+690": "Pacific/Pitcairn",      // Pitcairn Islands
            "+691": "Pacific/Pohnpei",       // Micronesia
            "+692": "Pacific/Kwajalein",     // Marshall Islands
            "+850": "Asia/Pyongyang",        // North Korea
            "+852": "Asia/Hong_Kong",        // Hong Kong
            "+853": "Asia/Macau",            // Macau
            "+855": "Asia/Phnom_Penh",       // Cambodia
            "+856": "Asia/Vientiane",        // Laos
            "+880": "Asia/Dhaka",            // Bangladesh
            "+886": "Asia/Taipei",           // Taiwan
            "+960": "Indian/Maldives",       // Maldives
            "+961": "Asia/Beirut",           // Lebanon
            "+962": "Asia/Amman",            // Jordan
            "+963": "Asia/Damascus",         // Syria
            "+964": "Asia/Baghdad",          // Iraq
            "+965": "Asia/Kuwait",           // Kuwait
            "+966": "Asia/Riyadh",           // Saudi Arabia
            "+967": "Asia/Aden",             // Yemen
            "+968": "Asia/Muscat",           // Oman
            "+971": "Asia/Dubai",            // United Arab Emirates
            "+972": "Asia/Jerusalem",        // Israel
            "+973": "Asia/Bahrain",          // Bahrain
            "+974": "Asia/Qatar",            // Qatar
            "+975": "Asia/Thimphu",          // Bhutan
            "+976": "Asia/Ulaanbaatar",      // Mongolia
            "+977": "Asia/Kathmandu",        // Nepal
            "+992": "Asia/Dushanbe",         // Tajikistan
            "+993": "Asia/Ashgabat",         // Turkmenistan
            "+994": "Asia/Baku",             // Azerbaijan
            "+995": "Asia/Tbilisi",          // Georgia
            "+996": "Asia/Bishkek",          // Kyrgyzstan
            "+998": "Asia/Tashkent"          // Uzbekistan
        ]

        
        guard let timeZoneIdentifier = timeZoneIdentifiers[countryCode],
              let timeZone = TimeZone(identifier: timeZoneIdentifier) else {
            return "Unknown Time"
        }
        
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = "HH:mm:ss"
        
        return formatter.string(from: Date())
    }
    
    
    func checkIfWithinWorkingHours(for countryCode: String) -> Bool {
        let timeZoneIdentifiers = [
            "07": "Africa/Nairobi",
            "+1": "America/New_York",        // United States/Canada (Eastern Time)
            "+7": "Asia/Novosibirsk",        // Russia
            "+20": "Africa/Cairo",           // Egypt
            "+27": "Africa/Johannesburg",    // South Africa
            "+30": "Europe/Athens",          // Greece
            "+31": "Europe/Amsterdam",       // Netherlands
            "+32": "Europe/Brussels",        // Belgium
            "+33": "Europe/Paris",           // France
            "+34": "Europe/Madrid",          // Spain
            "+36": "Europe/Budapest",        // Hungary
            "+39": "Europe/Rome",            // Italy
            "+40": "Europe/Bucharest",       // Romania
            "+41": "Europe/Zurich",          // Switzerland
            "+43": "Europe/Vienna",          // Austria
            "+44": "Europe/London",          // United Kingdom
            "+45": "Europe/Copenhagen",      // Denmark
            "+46": "Europe/Stockholm",       // Sweden
            "+47": "Europe/Oslo",            // Norway
            "+48": "Europe/Warsaw",          // Poland
            "+49": "Europe/Berlin",          // Germany
            "+51": "America/Lima",           // Peru
            "+52": "America/Mexico_City",    // Mexico
            "+53": "America/Havana",         // Cuba
            "+54": "America/Argentina/Buenos_Aires", // Argentina
            "+55": "America/Sao_Paulo",      // Brazil
            "+56": "America/Santiago",       // Chile
            "+57": "America/Bogota",         // Colombia
            "+58": "America/Caracas",        // Venezuela
            "+60": "Asia/Kuala_Lumpur",      // Malaysia
            "+61": "Australia/Sydney",       // Australia
            "+62": "Asia/Jakarta",           // Indonesia
            "+63": "Asia/Manila",            // Philippines
            "+64": "Pacific/Auckland",       // New Zealand
            "+65": "Asia/Singapore",         // Singapore
            "+66": "Asia/Bangkok",           // Thailand
            "+81": "Asia/Tokyo",             // Japan
            "+82": "Asia/Seoul",             // South Korea
            "+84": "Asia/Ho_Chi_Minh",       // Vietnam
            "+86": "Asia/Shanghai",          // China
            "+90": "Europe/Istanbul",        // Turkey
            "+91": "Asia/Kolkata",           // India
            "+92": "Asia/Karachi",           // Pakistan
            "+93": "Asia/Kabul",             // Afghanistan
            "+94": "Asia/Colombo",           // Sri Lanka
            "+95": "Asia/Yangon",            // Myanmar
            "+98": "Asia/Tehran",            // Iran
            "+211": "Africa/Juba",           // South Sudan
            "+212": "Africa/Casablanca",     // Morocco
            "+213": "Africa/Algiers",        // Algeria
            "+216": "Africa/Tunis",          // Tunisia
            "+218": "Africa/Tripoli",        // Libya
            "+220": "Africa/Banjul",         // Gambia
            "+221": "Africa/Dakar",          // Senegal
            "+222": "Africa/Nouakchott",     // Mauritania
            "+223": "Africa/Bamako",         // Mali
            "+224": "Africa/Conakry",        // Guinea
            "+225": "Africa/Abidjan",        // Ivory Coast
            "+226": "Africa/Ouagadougou",    // Burkina Faso
            "+227": "Africa/Niamey",         // Niger
            "+228": "Africa/Lome",           // Togo
            "+229": "Africa/Porto-Novo",     // Benin
            "+230": "Indian/Mauritius",      // Mauritius
            "+231": "Africa/Monrovia",       // Liberia
            "+232": "Africa/Freetown",       // Sierra Leone
            "+233": "Africa/Accra",          // Ghana
            "+234": "Africa/Lagos",          // Nigeria
            "+235": "Africa/Ndjamena",       // Chad
            "+236": "Africa/Bangui",         // Central African Republic
            "+237": "Africa/Douala",         // Cameroon
            "+238": "Atlantic/Cape_Verde",   // Cape Verde
            "+239": "Africa/Sao_Tome",       // Sao Tome and Principe
            "+240": "Africa/Malabo",         // Equatorial Guinea
            "+241": "Africa/Libreville",     // Gabon
            "+242": "Africa/Brazzaville",    // Republic of the Congo
            "+243": "Africa/Kinshasa",       // Democratic Republic of the Congo
            "+244": "Africa/Luanda",         // Angola
            "+245": "Africa/Bissau",         // Guinea-Bissau
            "+246": "Indian/Chagos",         // Diego Garcia
            "+247": "Atlantic/Ascension",    // Ascension Island
            "+248": "Indian/Mahe",           // Seychelles
            "+249": "Africa/Khartoum",       // Sudan
            "+250": "Africa/Kigali",         // Rwanda
            "+251": "Africa/Addis_Ababa",    // Ethiopia
            "+252": "Africa/Mogadishu",      // Somalia
            "+253": "Africa/Djibouti",       // Djibouti
            "+254": "Africa/Nairobi",        // Kenya
            "+255": "Africa/Dar_es_Salaam",  // Tanzania
            "+256": "Africa/Kampala",        // Uganda
            "+257": "Africa/Bujumbura",      // Burundi
            "+258": "Africa/Maputo",         // Mozambique
            "+260": "Africa/Lusaka",         // Zambia
            "+261": "Indian/Antananarivo",   // Madagascar
            "+262": "Indian/Reunion",        // Réunion/Mayotte
            "+263": "Africa/Harare",         // Zimbabwe
            "+264": "Africa/Windhoek",       // Namibia
            "+265": "Africa/Blantyre",       // Malawi
            "+266": "Africa/Maseru",         // Lesotho
            "+267": "Africa/Gaborone",       // Botswana
            "+268": "Africa/Mbabane",        // Eswatini
            "+269": "Indian/Comoro",         // Comoros
            "+290": "Atlantic/St_Helena",    // Saint Helena
            "+291": "Africa/Asmara",         // Eritrea
            "+297": "America/Aruba",         // Aruba
            "+298": "Atlantic/Faroe",        // Faroe Islands
            "+299": "America/Godthab",       // Greenland
            "+350": "Europe/Gibraltar",      // Gibraltar
            "+351": "Europe/Lisbon",         // Portugal
            "+352": "Europe/Luxembourg",     // Luxembourg
            "+353": "Europe/Dublin",         // Ireland
            "+354": "Atlantic/Reykjavik",    // Iceland
            "+355": "Europe/Tirane",         // Albania
            "+356": "Europe/Malta",          // Malta
            "+357": "Asia/Nicosia",          // Cyprus
            "+358": "Europe/Helsinki",       // Finland
            "+359": "Europe/Sofia",          // Bulgaria
            "+370": "Europe/Vilnius",        // Lithuania
            "+371": "Europe/Riga",           // Latvia
            "+372": "Europe/Tallinn",        // Estonia
            "+373": "Europe/Chisinau",       // Moldova
            "+374": "Asia/Yerevan",          // Armenia
            "+375": "Europe/Minsk",          // Belarus
            "+376": "Europe/Andorra",        // Andorra
            "+377": "Europe/Monaco",         // Monaco
            "+378": "Europe/San_Marino",     // San Marino
            "+379": "Europe/Vatican",        // Vatican City
            "+380": "Europe/Kiev",           // Ukraine
            "+381": "Europe/Belgrade",       // Serbia
            "+382": "Europe/Podgorica",      // Montenegro
            "+383": "Europe/Pristina",       // Kosovo
            "+385": "Europe/Zagreb",         // Croatia
            "+386": "Europe/Ljubljana",      // Slovenia
            "+387": "Europe/Sarajevo",       // Bosnia and Herzegovina
            "+389": "Europe/Skopje",         // North Macedonia
            "+420": "Europe/Prague",         // Czech Republic
            "+421": "Europe/Bratislava",     // Slovakia
            "+423": "Europe/Vaduz",          // Liechtenstein
            "+500": "Atlantic/Stanley",      // Falkland Islands
            "+501": "America/Belize",        // Belize
            "+502": "America/Guatemala",     // Guatemala
            "+503": "America/El_Salvador",   // El Salvador
            "+504": "America/Tegucigalpa",   // Honduras
            "+505": "America/Managua",       // Nicaragua
            "+506": "America/Costa_Rica",    // Costa Rica
            "+507": "America/Panama",        // Panama
            "+508": "America/Miquelon",      // Saint Pierre and Miquelon
            "+509": "America/Port-au-Prince",// Haiti
            "+590": "America/Guadeloupe",    // Guadeloupe
            "+591": "America/La_Paz",        // Bolivia
            "+592": "America/Guyana",        // Guyana
            "+593": "America/Guayaquil",     // Ecuador
            "+594": "America/Cayenne",       // French Guiana
            "+595": "America/Asuncion",      // Paraguay
            "+596": "America/Martinique",    // Martinique
            "+597": "America/Paramaribo",    // Suriname
            "+598": "America/Montevideo",    // Uruguay
            "+599": "America/Curacao",       // Curaçao
            "+670": "Asia/Dili",             // East Timor
            "+672": "Antarctica/Macquarie",  // Australian External Territories
            "+673": "Asia/Brunei",           // Brunei
            "+674": "Pacific/Nauru",         // Nauru
            "+675": "Pacific/Port_Moresby",  // Papua New Guinea
            "+676": "Pacific/Tongatapu",     // Tonga
            "+677": "Pacific/Guadalcanal",   // Solomon Islands
            "+678": "Pacific/Efate",         // Vanuatu
            "+679": "Pacific/Fiji",          // Fiji
            "+680": "Pacific/Palau",         // Palau
            "+681": "Pacific/Wallis",        // Wallis and Futuna
            "+682": "Pacific/Rarotonga",     // Cook Islands
            "+683": "Pacific/Niue",          // Niue
            "+685": "Pacific/Apia",          // Samoa
            "+686": "Pacific/Tarawa",        // Kiribati
            "+687": "Pacific/Noumea",        // New Caledonia
            "+688": "Pacific/Funafuti",      // Tuvalu
            "+689": "Pacific/Tahiti",        // French Polynesia
            "+690": "Pacific/Pitcairn",      // Pitcairn Islands
            "+691": "Pacific/Pohnpei",       // Micronesia
            "+692": "Pacific/Kwajalein",     // Marshall Islands
            "+850": "Asia/Pyongyang",        // North Korea
            "+852": "Asia/Hong_Kong",        // Hong Kong
            "+853": "Asia/Macau",            // Macau
            "+855": "Asia/Phnom_Penh",       // Cambodia
            "+856": "Asia/Vientiane",        // Laos
            "+880": "Asia/Dhaka",            // Bangladesh
            "+886": "Asia/Taipei",           // Taiwan
            "+960": "Indian/Maldives",       // Maldives
            "+961": "Asia/Beirut",           // Lebanon
            "+962": "Asia/Amman",            // Jordan
            "+963": "Asia/Damascus",         // Syria
            "+964": "Asia/Baghdad",          // Iraq
            "+965": "Asia/Kuwait",           // Kuwait
            "+966": "Asia/Riyadh",           // Saudi Arabia
            "+967": "Asia/Aden",             // Yemen
            "+968": "Asia/Muscat",           // Oman
            "+971": "Asia/Dubai",            // United Arab Emirates
            "+972": "Asia/Jerusalem",        // Israel
            "+973": "Asia/Bahrain",          // Bahrain
            "+974": "Asia/Qatar",            // Qatar
            "+975": "Asia/Thimphu",          // Bhutan
            "+976": "Asia/Ulaanbaatar",      // Mongolia
            "+977": "Asia/Kathmandu",        // Nepal
            "+992": "Asia/Dushanbe",         // Tajikistan
            "+993": "Asia/Ashgabat",         // Turkmenistan
            "+994": "Asia/Baku",             // Azerbaijan
            "+995": "Asia/Tbilisi",          // Georgia
            "+996": "Asia/Bishkek",          // Kyrgyzstan
            "+998": "Asia/Tashkent"          // Uzbekistan
        ]

        
        guard let timeZoneIdentifier = timeZoneIdentifiers[countryCode],
              let timeZone = TimeZone(identifier: timeZoneIdentifier) else {
            return false
        }
        
        let calendar = Calendar.current
        let currentDate = Date()
        let currentTime = calendar.dateComponents(in: timeZone, from: currentDate)
        
        if let hour = currentTime.hour {
            return hour >= 8 && hour < 17
        }
        
        return false
    }
    
    
    func checkAppropriateCommunicationChannel(for countryCode: String) -> Bool {
        let timeZoneIdentifiers = [
            "07": "Africa/Nairobi",
            "+1": "America/New_York",        // United States/Canada (Eastern Time)
            "+7": "Asia/Novosibirsk",        // Russia
            "+20": "Africa/Cairo",           // Egypt
            "+27": "Africa/Johannesburg",    // South Africa
            "+30": "Europe/Athens",          // Greece
            "+31": "Europe/Amsterdam",       // Netherlands
            "+32": "Europe/Brussels",        // Belgium
            "+33": "Europe/Paris",           // France
            "+34": "Europe/Madrid",          // Spain
            "+36": "Europe/Budapest",        // Hungary
            "+39": "Europe/Rome",            // Italy
            "+40": "Europe/Bucharest",       // Romania
            "+41": "Europe/Zurich",          // Switzerland
            "+43": "Europe/Vienna",          // Austria
            "+44": "Europe/London",          // United Kingdom
            "+45": "Europe/Copenhagen",      // Denmark
            "+46": "Europe/Stockholm",       // Sweden
            "+47": "Europe/Oslo",            // Norway
            "+48": "Europe/Warsaw",          // Poland
            "+49": "Europe/Berlin",          // Germany
            "+51": "America/Lima",           // Peru
            "+52": "America/Mexico_City",    // Mexico
            "+53": "America/Havana",         // Cuba
            "+54": "America/Argentina/Buenos_Aires", // Argentina
            "+55": "America/Sao_Paulo",      // Brazil
            "+56": "America/Santiago",       // Chile
            "+57": "America/Bogota",         // Colombia
            "+58": "America/Caracas",        // Venezuela
            "+60": "Asia/Kuala_Lumpur",      // Malaysia
            "+61": "Australia/Sydney",       // Australia
            "+62": "Asia/Jakarta",           // Indonesia
            "+63": "Asia/Manila",            // Philippines
            "+64": "Pacific/Auckland",       // New Zealand
            "+65": "Asia/Singapore",         // Singapore
            "+66": "Asia/Bangkok",           // Thailand
            "+81": "Asia/Tokyo",             // Japan
            "+82": "Asia/Seoul",             // South Korea
            "+84": "Asia/Ho_Chi_Minh",       // Vietnam
            "+86": "Asia/Shanghai",          // China
            "+90": "Europe/Istanbul",        // Turkey
            "+91": "Asia/Kolkata",           // India
            "+92": "Asia/Karachi",           // Pakistan
            "+93": "Asia/Kabul",             // Afghanistan
            "+94": "Asia/Colombo",           // Sri Lanka
            "+95": "Asia/Yangon",            // Myanmar
            "+98": "Asia/Tehran",            // Iran
            "+211": "Africa/Juba",           // South Sudan
            "+212": "Africa/Casablanca",     // Morocco
            "+213": "Africa/Algiers",        // Algeria
            "+216": "Africa/Tunis",          // Tunisia
            "+218": "Africa/Tripoli",        // Libya
            "+220": "Africa/Banjul",         // Gambia
            "+221": "Africa/Dakar",          // Senegal
            "+222": "Africa/Nouakchott",     // Mauritania
            "+223": "Africa/Bamako",         // Mali
            "+224": "Africa/Conakry",        // Guinea
            "+225": "Africa/Abidjan",        // Ivory Coast
            "+226": "Africa/Ouagadougou",    // Burkina Faso
            "+227": "Africa/Niamey",         // Niger
            "+228": "Africa/Lome",           // Togo
            "+229": "Africa/Porto-Novo",     // Benin
            "+230": "Indian/Mauritius",      // Mauritius
            "+231": "Africa/Monrovia",       // Liberia
            "+232": "Africa/Freetown",       // Sierra Leone
            "+233": "Africa/Accra",          // Ghana
            "+234": "Africa/Lagos",          // Nigeria
            "+235": "Africa/Ndjamena",       // Chad
            "+236": "Africa/Bangui",         // Central African Republic
            "+237": "Africa/Douala",         // Cameroon
            "+238": "Atlantic/Cape_Verde",   // Cape Verde
            "+239": "Africa/Sao_Tome",       // Sao Tome and Principe
            "+240": "Africa/Malabo",         // Equatorial Guinea
            "+241": "Africa/Libreville",     // Gabon
            "+242": "Africa/Brazzaville",    // Republic of the Congo
            "+243": "Africa/Kinshasa",       // Democratic Republic of the Congo
            "+244": "Africa/Luanda",         // Angola
            "+245": "Africa/Bissau",         // Guinea-Bissau
            "+246": "Indian/Chagos",         // Diego Garcia
            "+247": "Atlantic/Ascension",    // Ascension Island
            "+248": "Indian/Mahe",           // Seychelles
            "+249": "Africa/Khartoum",       // Sudan
            "+250": "Africa/Kigali",         // Rwanda
            "+251": "Africa/Addis_Ababa",    // Ethiopia
            "+252": "Africa/Mogadishu",      // Somalia
            "+253": "Africa/Djibouti",       // Djibouti
            "+254": "Africa/Nairobi",        // Kenya
            "+255": "Africa/Dar_es_Salaam",  // Tanzania
            "+256": "Africa/Kampala",        // Uganda
            "+257": "Africa/Bujumbura",      // Burundi
            "+258": "Africa/Maputo",         // Mozambique
            "+260": "Africa/Lusaka",         // Zambia
            "+261": "Indian/Antananarivo",   // Madagascar
            "+262": "Indian/Reunion",        // Réunion/Mayotte
            "+263": "Africa/Harare",         // Zimbabwe
            "+264": "Africa/Windhoek",       // Namibia
            "+265": "Africa/Blantyre",       // Malawi
            "+266": "Africa/Maseru",         // Lesotho
            "+267": "Africa/Gaborone",       // Botswana
            "+268": "Africa/Mbabane",        // Eswatini
            "+269": "Indian/Comoro",         // Comoros
            "+290": "Atlantic/St_Helena",    // Saint Helena
            "+291": "Africa/Asmara",         // Eritrea
            "+297": "America/Aruba",         // Aruba
            "+298": "Atlantic/Faroe",        // Faroe Islands
            "+299": "America/Godthab",       // Greenland
            "+350": "Europe/Gibraltar",      // Gibraltar
            "+351": "Europe/Lisbon",         // Portugal
            "+352": "Europe/Luxembourg",     // Luxembourg
            "+353": "Europe/Dublin",         // Ireland
            "+354": "Atlantic/Reykjavik",    // Iceland
            "+355": "Europe/Tirane",         // Albania
            "+356": "Europe/Malta",          // Malta
            "+357": "Asia/Nicosia",          // Cyprus
            "+358": "Europe/Helsinki",       // Finland
            "+359": "Europe/Sofia",          // Bulgaria
            "+370": "Europe/Vilnius",        // Lithuania
            "+371": "Europe/Riga",           // Latvia
            "+372": "Europe/Tallinn",        // Estonia
            "+373": "Europe/Chisinau",       // Moldova
            "+374": "Asia/Yerevan",          // Armenia
            "+375": "Europe/Minsk",          // Belarus
            "+376": "Europe/Andorra",        // Andorra
            "+377": "Europe/Monaco",         // Monaco
            "+378": "Europe/San_Marino",     // San Marino
            "+379": "Europe/Vatican",        // Vatican City
            "+380": "Europe/Kiev",           // Ukraine
            "+381": "Europe/Belgrade",       // Serbia
            "+382": "Europe/Podgorica",      // Montenegro
            "+383": "Europe/Pristina",       // Kosovo
            "+385": "Europe/Zagreb",         // Croatia
            "+386": "Europe/Ljubljana",      // Slovenia
            "+387": "Europe/Sarajevo",       // Bosnia and Herzegovina
            "+389": "Europe/Skopje",         // North Macedonia
            "+420": "Europe/Prague",         // Czech Republic
            "+421": "Europe/Bratislava",     // Slovakia
            "+423": "Europe/Vaduz",          // Liechtenstein
            "+500": "Atlantic/Stanley",      // Falkland Islands
            "+501": "America/Belize",        // Belize
            "+502": "America/Guatemala",     // Guatemala
            "+503": "America/El_Salvador",   // El Salvador
            "+504": "America/Tegucigalpa",   // Honduras
            "+505": "America/Managua",       // Nicaragua
            "+506": "America/Costa_Rica",    // Costa Rica
            "+507": "America/Panama",        // Panama
            "+508": "America/Miquelon",      // Saint Pierre and Miquelon
            "+509": "America/Port-au-Prince",// Haiti
            "+590": "America/Guadeloupe",    // Guadeloupe
            "+591": "America/La_Paz",        // Bolivia
            "+592": "America/Guyana",        // Guyana
            "+593": "America/Guayaquil",     // Ecuador
            "+594": "America/Cayenne",       // French Guiana
            "+595": "America/Asuncion",      // Paraguay
            "+596": "America/Martinique",    // Martinique
            "+597": "America/Paramaribo",    // Suriname
            "+598": "America/Montevideo",    // Uruguay
            "+599": "America/Curacao",       // Curaçao
            "+670": "Asia/Dili",             // East Timor
            "+672": "Antarctica/Macquarie",  // Australian External Territories
            "+673": "Asia/Brunei",           // Brunei
            "+674": "Pacific/Nauru",         // Nauru
            "+675": "Pacific/Port_Moresby",  // Papua New Guinea
            "+676": "Pacific/Tongatapu",     // Tonga
            "+677": "Pacific/Guadalcanal",   // Solomon Islands
            "+678": "Pacific/Efate",         // Vanuatu
            "+679": "Pacific/Fiji",          // Fiji
            "+680": "Pacific/Palau",         // Palau
            "+681": "Pacific/Wallis",        // Wallis and Futuna
            "+682": "Pacific/Rarotonga",     // Cook Islands
            "+683": "Pacific/Niue",          // Niue
            "+685": "Pacific/Apia",          // Samoa
            "+686": "Pacific/Tarawa",        // Kiribati
            "+687": "Pacific/Noumea",        // New Caledonia
            "+688": "Pacific/Funafuti",      // Tuvalu
            "+689": "Pacific/Tahiti",        // French Polynesia
            "+690": "Pacific/Pitcairn",      // Pitcairn Islands
            "+691": "Pacific/Pohnpei",       // Micronesia
            "+692": "Pacific/Kwajalein",     // Marshall Islands
            "+850": "Asia/Pyongyang",        // North Korea
            "+852": "Asia/Hong_Kong",        // Hong Kong
            "+853": "Asia/Macau",            // Macau
            "+855": "Asia/Phnom_Penh",       // Cambodia
            "+856": "Asia/Vientiane",        // Laos
            "+880": "Asia/Dhaka",            // Bangladesh
            "+886": "Asia/Taipei",           // Taiwan
            "+960": "Indian/Maldives",       // Maldives
            "+961": "Asia/Beirut",           // Lebanon
            "+962": "Asia/Amman",            // Jordan
            "+963": "Asia/Damascus",         // Syria
            "+964": "Asia/Baghdad",          // Iraq
            "+965": "Asia/Kuwait",           // Kuwait
            "+966": "Asia/Riyadh",           // Saudi Arabia
            "+967": "Asia/Aden",             // Yemen
            "+968": "Asia/Muscat",           // Oman
            "+971": "Asia/Dubai",            // United Arab Emirates
            "+972": "Asia/Jerusalem",        // Israel
            "+973": "Asia/Bahrain",          // Bahrain
            "+974": "Asia/Qatar",            // Qatar
            "+975": "Asia/Thimphu",          // Bhutan
            "+976": "Asia/Ulaanbaatar",      // Mongolia
            "+977": "Asia/Kathmandu",        // Nepal
            "+992": "Asia/Dushanbe",         // Tajikistan
            "+993": "Asia/Ashgabat",         // Turkmenistan
            "+994": "Asia/Baku",             // Azerbaijan
            "+995": "Asia/Tbilisi",          // Georgia
            "+996": "Asia/Bishkek",          // Kyrgyzstan
            "+998": "Asia/Tashkent"          // Uzbekistan
        ]

        guard let timeZoneIdentifier = timeZoneIdentifiers[countryCode],
              let timeZone = TimeZone(identifier: timeZoneIdentifier) else {
            return false
        }

        let calendar = Calendar.current
        let currentDate = Date()
        let currentTime = calendar.dateComponents(in: timeZone, from: currentDate)

        if let hour = currentTime.hour {
            switch hour {
            case 6..<9:
                // 6 AM - 9 AM: Early morning (e.g., email, schedule meetings)
                return true
            case 9..<12:
                // 9 AM - 12 PM: Morning work hours (e.g., call, text, email, meetings)
                return true
            case 12..<15:
                // 12 PM - 3 PM: Early afternoon (e.g., call, text, email, meetings)
                return true
            case 15..<18:
                // 3 PM - 6 PM: Late afternoon (e.g., text, email, meetings)
                return true
            case 18..<21:
                // 6 PM - 9 PM: Early evening (e.g., text, email)
                return true
            case 21..<24, 0..<6:
                // 9 PM - 6 AM: Night time (e.g., email, schedule meetings)
                return false
            default:
                return false
            }
        }

        return false
    }

    
    
}
