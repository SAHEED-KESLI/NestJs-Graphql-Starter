-- CreateEnum
CREATE TYPE "Industry" AS ENUM ('OTC_PHARMACEUTICALS', 'CONSUMER_GOODS', 'BEAUTY_AND_COSMETICS');

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "image" TEXT,
    "otp" TEXT,
    "otpExpiration" TIMESTAMP(3),
    "hashedJwtToken" TEXT,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Store" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "name" TEXT NOT NULL,
    "contact" TEXT NOT NULL,
    "locationId" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "manufacturerId" TEXT,

    CONSTRAINT "Store_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Distribution" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "name" TEXT NOT NULL,
    "batchNumber" TEXT NOT NULL,
    "storeId" TEXT NOT NULL,
    "productId" TEXT NOT NULL,

    CONSTRAINT "Distribution_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Manufacturer" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "ownerId" TEXT NOT NULL,
    "locationId" TEXT NOT NULL,
    "businessName" TEXT NOT NULL,
    "brandStoreName" TEXT NOT NULL,
    "industry" "Industry"[],
    "productCategory" JSONB NOT NULL,
    "slug" TEXT NOT NULL,
    "brandImage" TEXT NOT NULL,

    CONSTRAINT "Manufacturer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Product" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "name" TEXT NOT NULL,
    "imageUrl" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "retailPrice" TEXT,
    "quantity" INTEGER,
    "barCode" TEXT,
    "batchNumber" TEXT,
    "manufactureDate" TIMESTAMP(3),
    "expiryDate" TIMESTAMP(3),
    "manufacturerId" TEXT NOT NULL,

    CONSTRAINT "Product_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Location" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "fullAddress" TEXT NOT NULL,
    "longitude" DOUBLE PRECISION NOT NULL,
    "latitude" DOUBLE PRECISION NOT NULL,
    "metaData" JSONB NOT NULL,

    CONSTRAINT "Location_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Store_name_key" ON "Store"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Store_locationId_key" ON "Store"("locationId");

-- CreateIndex
CREATE UNIQUE INDEX "Store_slug_key" ON "Store"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Manufacturer_businessName_key" ON "Manufacturer"("businessName");

-- CreateIndex
CREATE UNIQUE INDEX "Manufacturer_slug_key" ON "Manufacturer"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Product_name_key" ON "Product"("name");

-- CreateIndex
CREATE INDEX "Location_latitude_longitude_idx" ON "Location"("latitude", "longitude");

-- AddForeignKey
ALTER TABLE "Store" ADD CONSTRAINT "Store_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "Location"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Store" ADD CONSTRAINT "Store_manufacturerId_fkey" FOREIGN KEY ("manufacturerId") REFERENCES "Manufacturer"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Distribution" ADD CONSTRAINT "Distribution_storeId_fkey" FOREIGN KEY ("storeId") REFERENCES "Store"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Distribution" ADD CONSTRAINT "Distribution_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Manufacturer" ADD CONSTRAINT "Manufacturer_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Manufacturer" ADD CONSTRAINT "Manufacturer_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "Location"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_manufacturerId_fkey" FOREIGN KEY ("manufacturerId") REFERENCES "Manufacturer"("id") ON DELETE CASCADE ON UPDATE CASCADE;
