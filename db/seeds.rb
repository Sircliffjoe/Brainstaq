

# ======================== CATEGORIES ====================================

# Define categories
categories = [
  {:name=>"Agriculture"}, {:name=>"Arts & Culture"}, {:name=>"Beauty & Fashion"}, 
  {:name=>"Business"}, {:name=>"Community"}, {:name=>"Design"}, {:name=>"Education"}, 
  {:name=>"Entertainment"}, {:name=>"Food"}, {:name=>"Gadgets"}, {:name=>"Internet"}, 
  {:name=>"IT & Telecoms"}, {:name=>"Kids"}, {:name=>"Media & Publishing"}, 
  {:name=>"Recipes"}, {:name=>"Renewable Energy"}, {:name=>"Science & Technology"}, 
  {:name=>"Social Networks"}, {:name=>"Social & Organization"}, {:name=>"Sports & Hobbies"}, 
  {:name=>"Startups"}, {:name=>"Sustainability"}, {:name=>"Tourism & Travel"}, 
  {:name=>"Transportation"}, {:name=>"Web & Applications"}, {:name=>"Writings"}, 
  {:name=>"Other"}, {:name=>"Accounting & Finance"}, {:name=>"Advertising"}, 
  {:name=>"Agricultural Equipment"}, {:name=>"Apparel & Textiles"}, {:name=>"Aquaculture"}, 
  {:name=>"Architecture"}, {:name=>"Artificial Intelligence (AI)"}, 
  {:name=>"Arts & Entertainment"}, {:name=>"Auditing"}, {:name=>"Automotive"}, 
  {:name=>"Banking & Financial Services"}, {:name=>"Blockchain Technology"}, 
  {:name=>"Building Materials"}, {:name=>"Building Materials Manufacturing"}, 
  {:name=>"Business Administration & Management"}, {:name=>"Business Analytics & Big Data"}, 
  {:name=>"Business Communication"}, {:name=>"Business Consulting & Services"}, 
  {:name=>"Business Ethics"}, {:name=>"Business Law & Ethics"}, 
  {:name=>"Business Model Innovation"}, {:name=>"Business Negotiation & Persuasion"}, 
  {:name=>"Business Statistics"}, {:name=>"Business Storytelling"}, 
  {:name=>"Business Sustainability"}, {:name=>"Business Writing & Communication"}, 
  {:name=>"Cash Crops (Coffee, Cocoa, Cotton)"}, {:name=>"Cassava Processing"}, 
  {:name=>"Cement Production"}, {:name=>"Chemical Production"}, {:name=>"Civil Engineering"}, 
  {:name=>"Cleaning & Janitorial Services"}, {:name=>"Coal Mining"}, 
  {:name=>"Construction & Real Estate"}, {:name=>"Construction Companies"}, 
  {:name=>"Consumer Goods Manufacturing"}, {:name=>"Content Marketing"}, 
  {:name=>"Corporate Social Responsibility (CSR)"}, {:name=>"Courier & Delivery Services"}, 
  {:name=>"Creative Industries (Film, Music, Fashion)"}, {:name=>"Cross-Cultural Management"}, 
  {:name=>"Customer Relationship Management (CRM)"}, {:name=>"Dairy Farming"}, 
  {:name=>"Data Analysis for Business"}, {:name=>"Design Thinking for Business"}, 
  {:name=>"Diagnostics & Medical Equipment"}, {:name=>"Diamond & Gemstone Mining"}, 
  {:name=>"Digital Marketing"}, {:name=>"E-commerce"}, {:name=>"Education & Training"}, 
  {:name=>"Effective Leadership Strategies"}, {:name=>"Electricity Generation & Distribution"}, 
  {:name=>"Electronics & Appliances"}, {:name=>"Engineering Services"}, 
  {:name=>"Entrepreneurship & Innovation"}, {:name=>"Event Management & Planning"}, 
  {:name=>"Facilities Management"}, {:name=>"Fashion Industry"}, {:name=>"Fashion Retail"}, 
  {:name=>"Fertilizer & Pesticides"}, {:name=>"Finance & Investment"}, 
  {:name=>"Financial Modeling & Valuation"}, {:name=>"FinTech (Financial Technology)"}, 
  {:name=>"Fish Farming"}, {:name=>"Food & Beverage Manufacturing"}, 
  {:name=>"Food & Beverage Retail"}, {:name=>"Food Processing & Packaging"}, 
  {:name=>"Forestry & Logging"}, {:name=>"Fruits & Vegetables"}, 
  {:name=>"Furniture & Homeware Retail"}, {:name=>"Furniture Manufacturing"}, 
  {:name=>"Global Marketing Strategies"}, {:name=>"Gold Mining"}, {:name=>"Grains & Cereals"}, 
  {:name=>"Grocery Stores & Supermarkets"}, {:name=>"Hairdressing & Salons"}, 
  {:name=>"Healthcare & Pharmaceuticals"}, {:name=>"Hospitality & Tourism"}, 
  {:name=>"Hospitals & Clinics"}, {:name=>"Human Resource Management (HRM)"}, 
  {:name=>"Human Resources & Recruitment"}, {:name=>"Human Resources Information Systems (HRIS)"}, 
  {:name=>"Information Technology (IT) Services"}, {:name=>"Insurance & Risk Management"}, 
  {:name=>"Interior Design & Decoration"}, {:name=>"International Business"}, 
  {:name=>"International Trade & Finance"}, {:name=>"Investment & Securities"}, 
  {:name=>"Investment Banking"}, {:name=>"Irrigation & Water Management"}, 
  {:name=>"Labor Relations & Compensation"}, {:name=>"Land Development"}, 
  {:name=>"Landscaping & Gardening"}, {:name=>"Leadership & Development"}, 
  {:name=>"Lean Startup Methodology"}, {:name=>"Legal Services"}, 
  {:name=>"Livestock Farming (Cattle, Poultry, Sheep)"}, {:name=>"Logistics"}, 
  {:name=>"Logistics & Supply Chain Management"}, {:name=>"Machinery"}, 
  {:name=>"Managing Teams & Conflict Resolution"}, {:name=>"Manufacturing"}, {:name=>"Marketing"}, 
  {:name=>"Marketing & Sales"}, {:name=>"Media & Broadcasting"}, 
  {:name=>"Medical Supplies & Pharmaceuticals"}, {:name=>"Mergers & Acquisitions (M&A)"}, 
  {:name=>"Metal & Mineral Mining"}, {:name=>"Metal Fabrication"}, {:name=>"Microfinance & Lending"}, 
  {:name=>"Mining & Resources"}, {:name=>"Mobile Money & Fintech"}, 
  {:name=>"Negotiation & Conflict Resolution"}, {:name=>"Nollywood"}, 
  {:name=>"Non-Profit Organizations"}, {:name=>"Oil & Gas Exploration & Production"}, 
  {:name=>"Operations Management"}, {:name=>"Organic Farming"}, {:name=>"Organizational Behavior"}, 
  {:name=>"Pharmaceuticals Manufacturing"}, {:name=>"Plastics & Rubber Production"}, 
  {:name=>"Private Equity"}, {:name=>"Project Management"}, 
  {:name=>"Project Management Methodologies"}, {:name=>"Property Management"}, 
  {:name=>"Public Health Services"}, {:name=>"Public Speaking"}, {:name=>"Real Estate Agencies"}, 
  {:name=>"Recycling"}, {:name=>"Renewable Energy"}, {:name=>"Risk Management & Insurance"}, 
  {:name=>"Search Engine Optimization (SEO)"}, {:name=>"Security Services"}, 
  {:name=>"Seed Production & Supply"}, {:name=>"Small Business Management"}, 
  {:name=>"Social Entrepreneurship"}, {:name=>"Social Media Marketing"}, 
  {:name=>"Software Development"}, {:name=>"Solid Waste Management"}, {:name=>"Spices & Herbs"}, 
  {:name=>"Sports & Fitness"}, {:name=>"Stock Market & Securities Trading"}, 
  {:name=>"Strategic Management"}, {:name=>"Strategic Planning"}, {:name=>"Supply Chain Management"}, 
  {:name=>"Talent Management"}, {:name=>"Telecommunications Services"}, 
  {:name=>"Transportation & Logistics"}, {:name=>"Waste Management"}, 
  {:name=>"Water Treatment & Sanitation"}, {:name=>"Wholesale Trade"}
]

# Create categories if they don't exist
categories.each do |category_data|
  Category.find_or_create_by(name: category_data[:name])
end

# ======================== SKILLS ====================================

# Define skills
skills = [
  {:name=>"3D Modeling"}, {:name=>"3D Printing"}, {:name=>"Accounting"}, {:name=>"Administration"}, 
  {:name=>"Agribusiness Management"}, {:name=>"Analytical"}, {:name=>"Animation"}, 
  {:name=>"App Development"}, {:name=>"Aquaponics"}, {:name=>"Architecture"}, 
  {:name=>"Artificial Intelligence (AI)"}, {:name=>"Attention to Details"}, {:name=>"AutoCAD"}, 
  {:name=>"Baking"}, {:name=>"Barbering"}, {:name=>"Bead Making"}, {:name=>"Blacksmithing"}, 
  {:name=>"Blockchain Technology"}, {:name=>"Brainstorming"}, {:name=>"Brand Management"}, 
  {:name=>"Bricklaying"}, {:name=>"Budgeting"}, {:name=>"Business Development"}, 
  {:name=>"Business Law"}, {:name=>"Calligraphy"}, {:name=>"Carpentry"}, {:name=>"Catering"}, 
  {:name=>"Child Care"}, {:name=>"Choreography"}, {:name=>"Cinematography"}, {:name=>"Coaching"}, 
  {:name=>"Coding"}, {:name=>"Comedy Writing"}, {:name=>"Communication"}, 
  {:name=>"Community Development"}, {:name=>"Community Health Education"}, 
  {:name=>"Composing Music"}, {:name=>"Computer Networking"}, {:name=>"Conceptualizing"}, 
  {:name=>"Conflict Resolution"}, {:name=>"Construction Management"}, {:name=>"Content Creation"}, 
  {:name=>"Contract Negotiation"}, {:name=>"Cooking"}, {:name=>"Copy Editing"}, 
  {:name=>"Counseling"}, {:name=>"Courier Services"}, {:name=>"Creative Direction"}, 
  {:name=>"Creative Thinking"}, {:name=>"Critical Thinking"}, {:name=>"Crop Farming"}, 
  {:name=>"Customer Relationship Management (CRM)"}, {:name=>"Customer Service"}, 
  {:name=>"Cyber Security"}, {:name=>"Dance"}, {:name=>"Dance Instruction"}, 
  {:name=>"Data Analysis"}, {:name=>"Data Encryption"}, {:name=>"Data Science"}, 
  {:name=>"Data Visualization"}, {:name=>"Database Management"}, {:name=>"Decision Making"}, 
  {:name=>"Delegation"}, {:name=>"Delivery Services"}, {:name=>"Digital Illustration"}, 
  {:name=>"Digital Marketing"}, {:name=>"Disk Jockey (DJ)"}, {:name=>"Drawing"}, {:name=>"Driving"}, 
  {:name=>"Early Childhood Education"}, {:name=>"Economic Analysis"}, {:name=>"Ecotourism Guiding"}, 
  {:name=>"Electrical Engineering"}, {:name=>"Entrepreneurial Thinking"}, 
  {:name=>"Environmental Conservation"}, {:name=>"Ethical Hacking"}, {:name=>"Ethical Sourcing"}, 
  {:name=>"Event Design"}, {:name=>"Event Management"}, {:name=>"Event Marketing"}, 
  {:name=>"Event Planning"}, {:name=>"Export/Import Procedures"}, {:name=>"Fair Trade Practices"}, 
  {:name=>"Fashion Design"}, {:name=>"Film Editing"}, {:name=>"Filmmaking"}, 
  {:name=>"Financial Management"}, {:name=>"Financial Modeling"}, {:name=>"Gardening"}, 
  {:name=>"Geographic Information Systems (GIS)"}, {:name=>"Grant Writing"}, {:name=>"Graphic Design"}, 
  {:name=>"Hairdressing"}, {:name=>"Home Repair"}, {:name=>"Hospitality & Tourism"}, 
  {:name=>"Human Resource Management (HRM)"}, {:name=>"Illustration"}, {:name=>"Instructional Design"}, 
  {:name=>"Instrument Playing"}, {:name=>"Instrument Repair"}, {:name=>"Interior Decorating"}, 
  {:name=>"Interior Design"}, {:name=>"International Business"}, {:name=>"International Development"}, 
  {:name=>"Internet of Things (IoT)"}, {:name=>"Inventory Management"}, {:name=>"Investment Banking"}, 
  {:name=>"Investor Relations"}, {:name=>"Jewelry Design"}, {:name=>"Jewelry Making"}, 
  {:name=>"Knitting"}, {:name=>"Land Management"}, {:name=>"Language Translation"}, 
  {:name=>"Leadership"}, {:name=>"Lean Startup Methodology"}, {:name=>"Legal Compliance"}, 
  {:name=>"Lighting Design"}, {:name=>"Listening"}, {:name=>"Livestock Management"}, 
  {:name=>"Local Governance"}, {:name=>"Logo Design"}, {:name=>"Lyric Writing"}, 
  {:name=>"Machine Learning"}, {:name=>"Market Research"}, {:name=>"Marketing"}, 
  {:name=>"Mental Health Counseling"}, {:name=>"Microfinance Management"}, 
  {:name=>"Mobile App Development"}, {:name=>"Mobile Money Management"}, 
  {:name=>"Multi-tasking"}, {:name=>"Music Production"}, {:name=>"Natural Language Processing (NLP)"}, 
  {:name=>"Natural Resource Management"}, {:name=>"Negotiation"}, {:name=>"Network Security"}, 
  {:name=>"Networking"}, {:name=>"Non-Profit Fundraising"}, {:name=>"Non-Profit Management"}, 
  {:name=>"Nursing"}, {:name=>"Observing"}, {:name=>"Operating Management"}, 
  {:name=>"Operations Research"}, {:name=>"Organizing"}, {:name=>"Painting"}, 
  {:name=>"Penetration Testing"}, {:name=>"Permaculture"}, {:name=>"Phone Repair"}, 
  {:name=>"Photography"}, {:name=>"Planning"}, {:name=>"Poetry Writing"}, {:name=>"Pottery"}, 
  {:name=>"Poultry Farming"}, {:name=>"Problem Solving"}, {:name=>"Programming"}, 
  {:name=>"Project Management Tools"}, {:name=>"Public Health Advocacy"}, 
  {:name=>"Public Relations (PR)"}, {:name=>"Quality Assurance (QA) Testing"}, 
  {:name=>"Renewable Energy Technology"}, {:name=>"Researching"}, {:name=>"Risk Management"}, 
  {:name=>"Robotics"}, {:name=>"Sales"}, {:name=>"Screenwriting"}, 
  {:name=>"Search Engine Optimization (SEO)"}, {:name=>"Security Services"}, {:name=>"Set Design"}, 
  {:name=>"Sewing"}, {:name=>"Singing"}, {:name=>"Social Development & Impact"}, 
  {:name=>"Social Enterprise Management"}, {:name=>"Social Media Management"}, 
  {:name=>"Social Media Marketing"}, {:name=>"Software Development"}, {:name=>"Soil Science"}, 
  {:name=>"Sound Design"}, {:name=>"Special Effects (SFX)"}, {:name=>"Special Needs Education"}, 
  {:name=>"Storytelling"}, {:name=>"Strategic Thinking"}, {:name=>"Styling"}, 
  {:name=>"Supply Chain Management"}, {:name=>"Sustainable Agriculture Practices"}, 
  {:name=>"Sustainable Building Practices"}, {:name=>"Sustainable Development Goals (SDGs)"}, 
  {:name=>"Sustainable Farming"}, {:name=>"System Administration"}, {:name=>"Talking/Speaking"}, 
  {:name=>"Teaching"}, {:name=>"Teaching English as a Second Language (TESL)"}, 
  {:name=>"Technical Writing"}, {:name=>"Test Preparation"}, {:name=>"Time Management"}, 
  {:name=>"Tourism Marketing"}, {:name=>"Traditional Manufacturing Techniques"}, 
  {:name=>"Transportation Services"}, {:name=>"Troubleshooting"}, {:name=>"Typing"}, 
  {:name=>"UI/UX Design"}, {:name=>"Unity (game development)"}, 
  {:name=>"Unreal Engine (game development)"}, {:name=>"User Experience (UX) Design"}, 
  {:name=>"Venture Capital"}, {:name=>"Vertical Farming"}, {:name=>"Video Editing"}, 
  {:name=>"Virtual Reality (VR) Development"}, {:name=>"Vocational Training"}, 
  {:name=>"Water Management"}, {:name=>"Web Design"}, {:name=>"Website Development"}, 
  {:name=>"Wildlife Conservation"}, {:name=>"Workflow Management"}, {:name=>"Writing"}
]

# Create skills if they don't exist
skills.each do |skill_name|
  Skill.find_or_create_by(name: skill_name)
end


# ======================== BUSINESS IDEA TEMPLATES ====================================

# Define business idea templates with categories and required skills

business_idea_templates = [
  {
    name: "Digital Out of Home Advertising", 
    description: "Digital Out of Home (DOOH) Advertising leverages digital screens and technologies to deliver dynamic and engaging advertisements in public spaces. Unlike traditional billboards, DOOH can display interactive and multimedia content, adapting to the audience's preferences and demographics. This form of advertising is becoming increasingly popular in urban areas, shopping malls, transportation hubs, and stadiums. It offers brands a powerful way to reach consumers on the go, providing real-time updates and personalized messages. The integration of advanced technologies like geolocation, facial recognition, and data analytics allows for highly targeted advertising campaigns, maximizing the impact and return on investment.", 
    problems: "Limited engagement and interactivity of traditional billboards.\n Inefficiency in reaching target demographics.\n High costs associated with changing traditional billboard advertisements.\n Difficulty in measuring the effectiveness of traditional out-of-home advertising.", 
    solutions: "Utilize digital screens to display dynamic, interactive content.\n Implement data analytics and geolocation technologies to target specific demographics.\n Enable real-time updates and changes to advertising content, reducing costs.\n Use sensors and analytics to measure audience engagement and campaign effectiveness.", 
    products_services: "Digital billboards and screens.\n Content management systems for real-time updates.\n Data analytics and reporting tools.\n Interactive advertisement solutions (touchscreens, AR, etc.).\n Installation and maintenance services.", 
    market_info: "The African market is experiencing rapid urbanization and a growing middle class, creating a fertile ground for DOOH advertising. Major cities like Lagos, Johannesburg, Nairobi, and Cairo have high foot traffic and a tech-savvy population. There is also a significant increase in the number of shopping malls and public spaces, providing ample opportunities for DOOH installations.", 
    requirements: "Investment in digital screens and display technology.\n Skilled personnel for installation and maintenance.\n Partnerships with property owners and local authorities.\n Robust data analytics and content management systems.\n Marketing and sales teams to attract and retain clients.\n Compliance with local advertising regulations and standards.",
    category_name: "Advertising",
    required_skills: ['Digital Marketing', 'Graphic Design', 'Marketing', 'Business Development', 'Sales', 'Customer Service', 'Advertising Technology', 'Analytical']
  },

  {
    name: "Online Advertising Business",
    description: "An online advertising business focuses on promoting products and services through digital channels such as social media, search engines, websites, and mobile apps. It encompasses various forms of advertising, including display ads, video ads, social media ads, and search engine marketing. Online advertising offers precise targeting options based on user demographics, interests, and behaviors, making it a cost-effective solution for reaching a wide audience. This business leverages advanced technologies like programmatic advertising, artificial intelligence, and big data analytics to optimize ad performance and maximize return on investment for clients.",
    problems: "High competition and noise in the online space.\n Difficulty in reaching the right audience with traditional advertising methods.\n Ineffective ad placements and poor return on investment.\n Limited access to advanced advertising tools and technologies for small businesses.",
    solutions: "Use advanced targeting and retargeting techniques to reach the right audience.\n Employ programmatic advertising for efficient ad placement.\n Utilize big data analytics to optimize ad performance and ROI.\n Provide access to affordable and effective advertising solutions for small businesses.",
    products_services: "Social media advertising campaigns.\n Search engine marketing (SEM) and optimization (SEO).\n Display and video advertising.\n Programmatic advertising solutions.\n Analytics and reporting services.\n Consulting and strategy development.",
    market_info: "The African market is witnessing a significant increase in internet penetration and mobile phone usage, particularly among the youth. Social media platforms like Facebook, Instagram, and Twitter have large user bases in Africa, making them ideal channels for online advertising. Additionally, the growing e-commerce sector in Africa presents opportunities for online advertisers to tap into a burgeoning market.",
    category_name: "Advertising",
    required_skills: ["Marketing Strategy", "Advertising", "Business Development", "Sales", "Customer Service", "Digital Marketing", "Creative Direction", "Analytics"]

  },

  {
    name: "Agricultural Drone Services",
    description: "Agricultural drone services involve the use of unmanned aerial vehicles (UAVs) to assist in various farming activities. These drones can be equipped with cameras, sensors, and spraying systems to monitor crop health, survey land, and apply fertilizers or pesticides. They provide farmers with high-resolution images and data that can be used to make informed decisions, improve crop yields, and reduce costs. Agricultural drones offer a more efficient and precise way of managing large farms, ensuring optimal use of resources and minimizing environmental impact.",
    problems: "Inaccurate and labor-intensive crop monitoring methods.\n Inefficient use of fertilizers and pesticides leading to waste and pollution.\n Difficulty in managing large and remote farmlands.\n Lack of real-time data on crop health and growth.",
    solutions: "Deploy drones for regular and precise crop monitoring.\n Use drones to apply fertilizers and pesticides accurately.\n Employ drones for surveying and mapping large agricultural lands.\n Integrate drones with data analytics platforms to provide real-time insights.",
    products_services: "Crop health monitoring and imaging services.\n Precision agriculture services (fertilizer and pesticide application).\n Land surveying and mapping.\n Data analysis and reporting services.\n Drone sales and maintenance.",
    market_info: "Africa has a vast agricultural sector with large tracts of arable land. However, traditional farming methods often result in inefficiencies and lower yields. The adoption of agricultural drones can revolutionize farming practices, particularly in countries like Nigeria, Kenya, and South Africa, where there is a push towards modernizing agriculture. The increasing focus on food security and sustainable farming practices in Africa further underscores the potential for agricultural drone services.",
    requirements: "Investment in high-quality drones and related equipment.\n Skilled drone operators and data analysts.\n Partnerships with local farmers and agricultural organizations.\n Training programs for farmers on the benefits and usage of drone technology.\n Compliance with aviation regulations and safety standards.\n Development of data management and analytics platforms.",
    category_name: "Agricultural Equipment",
    required_skills: ["Drone Operation, Data Analysis, Geographic Information Systems (GIS), Marketing, Customer Service
"]
  },

  {
    name: "Agricultural Technology Solutions (AgTech)",
    description: "Agricultural technology solutions (AgTech) encompass a wide range of technologies aimed at improving the efficiency, productivity, and sustainability of farming practices. These solutions include precision farming tools, IoT devices, data analytics, automation, and biotechnology. AgTech helps farmers optimize their resources, monitor crop health, and make data-driven decisions. By integrating technology into agriculture, farmers can enhance crop yields, reduce waste, and ensure sustainable farming practices. The ultimate goal of AgTech is to address the global challenges of food security, resource management, and environmental sustainability.",
    problems: "Low agricultural productivity and inefficient resource use.\n Lack of real-time data for decision-making.\n Challenges in managing pest and disease outbreaks.\n High labor costs and manual farming methods.",
    solutions: "Implement precision farming tools to optimize resource use.\n Use IoT devices and sensors for real-time monitoring and data collection.\n Employ data analytics to provide actionable insights for farmers.\n Introduce automation and robotics to reduce labor costs and improve efficiency.",
    products_services: "Precision farming tools (GPS-guided equipment, soil sensors).\n IoT devices for monitoring environmental conditions.\n Data analytics platforms and software.\n Automation solutions (drones, robots).\n Biotechnology products (genetically modified seeds, bio-pesticides).",
    market_info: "The African agricultural sector is ripe for technological transformation, with a growing emphasis on improving productivity and sustainability. Countries like Kenya, Nigeria, and Ghana are seeing increased investments in AgTech startups. The adoption of technology in agriculture is driven by the need to feed a rapidly growing population and mitigate the impacts of climate change. Access to mobile technology and the internet also facilitates the deployment of AgTech solutions in rural areas.",
    requirements: "Investment in research and development of agricultural technologies.\n Collaboration with agricultural experts and researchers.\n Training programs for farmers on the use of AgTech solutions.\n Strong distribution networks to reach rural farmers.\n Partnerships with government agencies and agricultural organizations.\n Robust data security and privacy measures.",
    category_name: "Agricultural Equipment",
    required_skills: ["Agricultural Engineering, Data Analysis, Project Management Tools, Marketing, Business Development"]
  },

  {
    name: "Farming Equipment Leasing",
    description: "Farming equipment leasing involves providing farmers with access to modern agricultural machinery and equipment on a rental basis. This business model addresses the high cost of purchasing equipment outright, making it more affordable for small and medium-sized farms to access the tools they need. Equipment leasing can include tractors, plows, harvesters, irrigation systems, and more. By leasing equipment, farmers can improve their productivity, reduce labor costs, and manage their farms more efficiently without the financial burden of owning expensive machinery.",
    problems: "High upfront costs of purchasing farming equipment.\n Limited access to modern agricultural machinery for small-scale farmers.\n Inefficient farming practices due to lack of proper equipment.\n High maintenance and repair costs for owned equipment.",
    solutions: "Offer flexible leasing options to make equipment more accessible.\n Provide a variety of modern farming equipment for different agricultural needs.\n Include maintenance and repair services in leasing agreements.\n Educate farmers on the benefits and usage of leased equipment.",
    products_services: "Leasing of tractors, plows, and harvesters.\n Rental of irrigation systems and equipment.\n Maintenance and repair services.\n Training and support services for equipment operation.\n Customized leasing plans based on farm size and needs.",
    market_info: "The agricultural sector in Africa is characterized by a high number of small-scale farmers who often lack access to modern equipment. Countries like Nigeria, Ethiopia, and Tanzania are investing in agricultural mechanization to boost productivity. Equipment leasing offers a viable solution to bridge the gap, enabling farmers to access necessary machinery without significant financial investment. The growing focus on agricultural development and mechanization in Africa presents a significant opportunity for the farming equipment leasing business.",
    requirements: "Investment in a fleet of modern agricultural machinery and equipment.\n Skilled technicians for maintenance and repairs.\n Strong marketing and outreach programs to educate farmers about leasing options.\n Collaboration with agricultural cooperatives and organizations.\n Development of flexible and affordable leasing plans.\n Compliance with local regulations and standards for agricultural equipment.",
    category_name: "Agricultural Equipment",
    required_skills: ["Agricultural Management, Marketing, Business Development, Sales, Customer Service, Inventory Management, Leasing & Financing, Technical Support"]
  },

  {
    name: "Livestock Feed Production",
    description: "Livestock feed production involves the manufacturing and distribution of high-quality feed for various types of livestock, including poultry, cattle, goats, and sheep. This business aims to provide balanced and nutritious feed formulations that cater to the dietary needs of different animals at various stages of growth. By producing feed locally, the business can ensure consistent supply, reduce import dependency, and offer cost-effective solutions to farmers. The business can also incorporate locally available ingredients to tailor the feed to regional requirements, enhancing the growth and productivity of livestock.",
    problems: "High costs and inconsistent supply of imported livestock feed.\n Poor nutritional quality of locally available feed.\n Limited access to specialized feed formulations for different livestock.\n Lack of awareness and education among farmers about proper animal nutrition.",
    solutions: "Establish local feed production facilities to ensure consistent supply.\n Use high-quality ingredients and scientifically formulated recipes.\n Offer a range of specialized feed formulations for different livestock.\n Educate farmers about the benefits of using balanced and nutritious feed.",
    products_services: "Poultry feed.\n Cattle feed.\n Goat and sheep feed.\n Specialized feed for different growth stages (starter, grower, finisher).\n Custom feed formulations.\n Nutritional consulting services for farmers.",
    market_info: "The demand for livestock products in Africa is increasing due to population growth and rising incomes. Countries like Nigeria, Kenya, and South Africa have significant livestock farming activities, creating a large market for quality feed. The local production of livestock feed can reduce costs, improve livestock health and productivity, and support the growth of the livestock sector.",
    requirements: "Investment in feed production machinery and facilities.\n Access to high-quality raw materials and ingredients.\n Knowledge of animal nutrition and feed formulation.\n Skilled labor for production and quality control.\n Distribution network to reach local farmers.\n Marketing and educational programs to promote the benefits of quality feed.",
    category_name: "Agricultural Equipment",
    required_skills: ['Livestock Management', 'Manufacturing Processes', 'Marketing', 'Business Development', 'Sales', 'Inventory Management', 'Quality Assurance (QA) Testing', 'Health & Safety Management']
  },

  {
    name: "Palm Kernel Oil Extraction",
    description: "Palm kernel oil extraction involves the processing of palm kernels to produce palm kernel oil (PKO) and palm kernel cake (PKC). PKO is a versatile oil used in food, cosmetics, and industrial applications, while PKC serves as a high-protein feed for livestock. This business capitalizes on the abundant availability of palm fruits in many African countries, particularly in West Africa. The extraction process includes cracking the kernels, separating the shells, and extracting the oil through mechanical or solvent methods. By setting up local extraction facilities, the business can add value to raw materials, create jobs, and reduce waste.",
    problems: "High import costs of palm kernel oil and related products.\n Limited value addition to locally grown palm fruits.\n Waste management issues related to palm kernel processing.\n Inconsistent quality of locally produced palm kernel oil.",
    solutions: "Establish efficient palm kernel oil extraction plants.\n Implement quality control measures to ensure high standards.\n Utilize by-products like palm kernel cake as livestock feed.\n Educate farmers and processors on best practices for harvesting and processing.",
    products_services: "Palm kernel oil.\n Palm kernel cake.\n By-product utilization services.\n Technical support and training for farmers and processors.\n Packaging and distribution services.",
    market_info: "The palm oil industry is significant in countries like Nigeria, Ghana, and Ivory Coast. There is a strong demand for PKO in both domestic and international markets. Local extraction can reduce reliance on imports, provide income for smallholder farmers, and contribute to the growth of the agro-processing sector.",
    requirements: "Investment in extraction machinery and processing facilities.\n Access to a steady supply of palm kernels.\n Skilled labor for processing and quality control.\n Compliance with food safety and quality standards.\n Strong distribution network for PKO and PKC.\n Marketing strategies to promote locally produced palm kernel oil.",
    category_name: "Agricultural Equipment",
    required_skills: ["Oil Extraction", "Manufacturing Processes", "Quality Assurance (QA) Testing", "Marketing", "Business Development", "Sales", "Inventory Management", "Health & Safety Management"]
  },

  {
    name: "Post-Harvest Loss Reduction Solutions",
    description: "Post-harvest loss reduction solutions focus on minimizing the loss of agricultural produce after harvesting, which can be as high as 30-50% in some African countries. These solutions involve the use of technologies and practices that preserve the quality and quantity of crops during storage, transportation, and processing. Implementing post-harvest technologies like improved storage facilities, cold chains, drying equipment, and packaging materials can significantly reduce losses. By addressing this issue, the business aims to enhance food security, increase farmers' incomes, and reduce waste.",
    problems: "High rates of spoilage and loss of agricultural produce.\n Lack of proper storage facilities and transportation infrastructure, especially in rural areas.\n Limited access to affordable and efficient post-harvest technologies for smallholder farmers.\n Insufficient knowledge among farmers and stakeholders about proper post-harvest handling practices.",
    solutions: "Develop and provide access to modern storage facilities and cold chains.\n Introduce affordable and efficient drying and packaging technologies.\n Educate farmers and stakeholders on best post-harvest handling practices.\n Collaborate with governments and organizations to improve infrastructure.",
    products_services: "Improved storage solutions (silos, warehouses, cold rooms).\n Drying equipment (solar dryers, mechanical dryers).\n Packaging materials and technologies (hermetic bags, specialized crates).\n Training and consultancy services on post-harvest management.\n Transportation and logistics services.",
    market_info: "Post-harvest losses are a significant challenge across Africa, impacting food security and economic growth. Countries like Nigeria, Kenya, and Uganda are focusing on reducing these losses through various initiatives. Implementing effective post-harvest solutions can transform the agricultural value chain, ensuring that more produce reaches the market in good condition. The growing demand for locally produced food, coupled with rising awareness about food waste reduction, presents a significant opportunity for this business.",
    requirements: "Investment in post-harvest technologies and infrastructure.\n Collaboration with agricultural experts and organizations.\n Training programs for farmers and handlers.\n Development of affordable and scalable solutions.\n Strong distribution and logistics network.\n Advocacy and partnerships with government agencies.",
    category_name: "Agricultural Technology Solutions",
    required_skills: ["Agricultural Management", "Food Processing", "Marketing", "Business Development", "Sales", "Quality Assurance (QA) Testing", "Inventory Management", "Sustainability Practices"]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },

  {
    name: "",
    description: "",
    problems: "",
    solutions: "",
    products_services: "",
    market_info: "",
    requirements: "",
    category_name: "",
    required_skills: [""]
  },



]




# Create business ideas with categories and skills if they don't exist
business_idea_templates.each do |idea_data|
  category = Category.find_by(name: idea_data[:category_name])
  business_idea = BusinessIdea.find_or_create_by(name: idea_data[:name], description: idea_data[:description], category: category)
  
  idea_data[:required_skills].each do |skill_name|
    skill = Skill.find_by(name: skill_name)
    business_idea.skills << skill if skill && !business_idea.skills.include?(skill)
  end
end