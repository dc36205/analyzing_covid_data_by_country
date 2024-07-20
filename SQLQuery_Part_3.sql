--SELECT TOP (1000) [UniqueID ]
--      ,[ParcelID]
--      ,[LandUse]
--      ,[PropertyAddress]
--      ,[SaleDate]
--      ,[SalePrice]
--      ,[LegalReference]
--      ,[SoldAsVacant]
--      ,[OwnerName]
--      ,[OwnerAddress]
--      ,[Acreage]
--      ,[TaxDistrict]
--      ,[LandValue]
--      ,[BuildingValue]
--      ,[TotalValue]
--      ,[YearBuilt]
--      ,[Bedrooms]
--      ,[FullBath]
--      ,[HalfBath]
--  FROM [PortfolioProject].[dbo].[NashvilleHousing]

/* 

Clenaing Data in SQl Queries

*/

--Select *
--From PortfolioProject.dbo.NashvilleHousing

----------------------------------------------------------------------------

--Standardize Date Format

--Select saleDateConverted, CONVERT(Date, SaleDate) 
--From PortfolioProject.dbo.NashvilleHousing

--Update NashvilleHousing
--SET SaleDate = CONVERT(Date, SaleDate) 

--ALTER TABLE NashvilleHousing
--Add SaleDateConverted Date;

--Update NashvilleHousing
--SET SaleDateConverted = CONVERT(Date, SaleDate) 

--------------------------------------------------------------------------------------

--Population Property Address data

--Select *
--From PortfolioProject.dbo.NashvilleHousing
----where  PropertyAddress is NULL
--order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress) 
From PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
     on a.ParcelID = b.ParcelID
	 AND a.[UniqueID]  <> b.[UniqueID]
where a.PropertyAddress is NULL 

Update a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
From PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
     on a.ParcelID = b.ParcelID
	 AND a.[UniqueID] <> b.[UniqueID]
where a.PropertyAddress is NULL 

-------------------------------------------------------
--Breaking out Address into Individual  columns (columns, City, State)

Select PropertyAddress
From PortfolioProject.dbo.NashvilleHousing
--where  PropertyAddress is NULL
--order by ParcelID

--with this i remove the coma in the last part of the address 
SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address   
From PortfolioProject.dbo.NashvilleHousing


ALTER TABLE NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

Update NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) 

ALTER TABLE NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) 


Select *
From PortfolioProject.dbo.NashvilleHousing


Select OwnerAddress
From PortfolioProject.dbo.NashvilleHousing


Select 
PARSENAME(REPLACE(ownerAddress, ',', '.'), 3)  
,PARSENAME(REPLACE(ownerAddress, ',', '.'), 2)   
,PARSENAME(REPLACE(ownerAddress, ',', '.'), 1)  
From PortfolioProject.dbo.NashvilleHousing



ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(ownerAddress, ',', '.'), 3)  

ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(ownerAddress, ',', '.'), 2)  
 

ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(ownerAddress, ',', '.'), 1)  


Select *
From PortfolioProject.dbo.NashvilleHousing

----------------------------------------------------------------------------

-- Change the Y and N to Yes and No in "Sold As Vacant" field

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From PortfolioProject.dbo.NashvilleHousing
Group by SoldAsVacant
Order by 2

Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
     When SoldAsVacant = 'N' THEN 'No'
    ELSE SoldAsVacant
    END
From PortfolioProject.dbo.NashvilleHousing


update NashvilleHousing 
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
     When SoldAsVacant = 'N' THEN 'No'
    ELSE SoldAsVacant
    END

----------------------------------------------------------------------------

-- Remove duplicates

WITH RownumCTE AS(
Select *, 
	ROW_NUMBER() OVER(
	PARTITION BY ParcelID, 
	             PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY 
				     UniqueID
					 )row_num

From PortfolioProject.dbo.NashvilleHousing
--order by ParcelID   --quitar el order by in the CTE!!!!!!!!!!!!!

)
--DELETE
--From RownumCTE
----where row_num > 1
--Order by PropertyAddress


Select *
From RownumCTE
where row_num > 1
Order by PropertyAddress
 

----------------------------------------------------------------------------

-- Delete Unused Columns


Select *
From PortfolioProject.dbo.NashvilleHousing

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN  OwnerAddress, TaxDistrict, PropertyAddress













