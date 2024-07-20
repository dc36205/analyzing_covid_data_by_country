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






















