
CREATE TABLE "MountainLocations" (
    "LocationID" SERIAL PRIMARY KEY,
    "CountryID" BIGINT NOT NULL,
    "Location" VARCHAR(255) NOT NULL,
    "record_ts" TIMESTAMP DEFAULT CURRENT_DATE NOT NULL
);


CREATE TABLE "Alpinists" (
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(255) NOT NULL,
    "birthday" DATE NOT NULL,
    "gender" VARCHAR(10) CHECK (gender IN ('Male', 'Female', 'Other')),
    "record_ts" TIMESTAMP DEFAULT CURRENT_DATE NOT NULL
);


CREATE TABLE "Climbs" (
    "ClimbID" SERIAL PRIMARY KEY,
    "AlpinistID" BIGINT NOT NULL,
    "MountainID" BIGINT NOT NULL,
    "date_start" DATE CHECK (date_start > '2000-01-01'),
    "date_end" DATE CHECK (date_end > date_start),
    "record_ts" TIMESTAMP DEFAULT CURRENT_DATE NOT NULL
);


CREATE TABLE "Equipment" (
    "EquipmentID" SERIAL PRIMARY KEY,
    "Name" VARCHAR(255) NOT NULL,
    "Description" VARCHAR(255) NOT NULL,
    "record_ts" TIMESTAMP DEFAULT CURRENT_DATE NOT NULL
);


CREATE TABLE "ClimbingEquipment" (
    "ClimbingEquipmentID" SERIAL PRIMARY KEY,
    "ClimbID" BIGINT NOT NULL,
    "EquipmentID" BIGINT NOT NULL,
    "Quantity" BIGINT NOT NULL,
    "record_ts" TIMESTAMP DEFAULT CURRENT_DATE NOT NULL
);


CREATE TABLE "Mountains" (
    "MountainID" SERIAL PRIMARY KEY,
    "Name" VARCHAR(255) NOT NULL,
    "High" BIGINT NOT NULL,
    "LocationID" BIGINT NOT NULL,
    "record_ts" TIMESTAMP DEFAULT CURRENT_DATE NOT NULL
);


CREATE TABLE "Countries" (
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(255) NOT NULL,
    "record_ts" TIMESTAMP DEFAULT CURRENT_DATE NOT NULL
);


CREATE TABLE "ClimbingPartners" (
    "PartnerID" SERIAL PRIMARY KEY,
    "AlpinistID" BIGINT NOT NULL,
    "ClimbID" BIGINT NOT NULL,
    "record_ts" TIMESTAMP DEFAULT CURRENT_DATE NOT NULL
);




ALTER TABLE "Mountains" ADD CONSTRAINT "mountains_locationid_foreign" FOREIGN KEY("LocationID") REFERENCES "MountainLocations"("LocationID");
ALTER TABLE "ClimbingPartners" ADD CONSTRAINT "climbingpartners_alpinistid_foreign" FOREIGN KEY("AlpinistID") REFERENCES "Alpinists"("id");
ALTER TABLE "ClimbingPartners" ADD CONSTRAINT "climbingpartners_climbid_foreign" FOREIGN KEY("ClimbID") REFERENCES "Climbs"("ClimbID");
ALTER TABLE "MountainLocations" ADD CONSTRAINT "mountainlocations_countryid_foreign" FOREIGN KEY("CountryID") REFERENCES "Countries"("id");
ALTER TABLE "Climbs" ADD CONSTRAINT "climbs_alpinistid_foreign" FOREIGN KEY("AlpinistID") REFERENCES "Alpinists"("id");
ALTER TABLE "ClimbingEquipment" ADD CONSTRAINT "climbingequipment_climbid_foreign" FOREIGN KEY("ClimbID") REFERENCES "Climbs"("ClimbID");
ALTER TABLE "Climbs" ADD CONSTRAINT "climbs_mountainid_foreign" FOREIGN KEY("MountainID") REFERENCES "Mountains"("MountainID");
ALTER TABLE "ClimbingEquipment" ADD CONSTRAINT "climbingequipment_equipmentid_foreign" FOREIGN KEY("EquipmentID") REFERENCES "Equipment"("EquipmentID");


ALTER TABLE "Climbs"
ADD CONSTRAINT "check_start_date" CHECK (date_start > '2000-01-01');


ALTER TABLE "Climbs"
ADD CONSTRAINT "unique_alpinist_mountain_date" UNIQUE ("AlpinistID", "MountainID", "date_start");


ALTER TABLE "Climbs"
ALTER COLUMN "date_start" SET NOT NULL;


ALTER TABLE "Climbs"
ALTER COLUMN "date_end" SET NOT NULL;


ALTER TABLE "ClimbingEquipment"
ADD CONSTRAINT "check_quantity_positive" CHECK ("Quantity" >= 0);


INSERT INTO "Countries" ("name", "record_ts") VALUES ('Belarus', current_date);


Select * FROM "Countries";


