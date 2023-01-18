


# Azure Data Engineer Associate Certification Guide

<a href="https://www.packtpub.com/product/dp-203-azure-data-engineer-associate-certification-guide/9781801816069?utm_source=github&utm_medium=repository&utm_campaign=9781801816069"><img src="https://static.packt-cdn.com/products/9781801816069/cover/smaller" alt="Azure Data Engineer Associate Certification Guide" height="256px" align="right"></a>

This is the code repository for [Azure Data Engineer Associate Certification Guide](https://www.packtpub.com/product/dp-203-azure-data-engineer-associate-certification-guide/9781801816069?utm_source=github&utm_medium=repository&utm_campaign=9781801816069), published by Packt.

**A hands-on reference guide to developing your data engineering skills and preparing for the DP-203 exam**

## What is this book about?
The DP-203: Azure Data Engineer Associate Certification Guide offers complete coverage of the DP-203 certification requirements so that you can take the exam with confidence. Going beyond the requirements for the exam, 
this book also provides you with additional knowledge to enable you to succeed in your real-life Azure data engineering projects.


This book covers the following exciting features: 
* Gain intermediate-level knowledge of Azure the data infrastructure
* Design and implement data lake solutions with batch and stream pipelines
* Identify the partition strategies available in Azure storage technologies
* Implement different table geometries in Azure Synapse Analytics
* Use the transformations available in T-SQL, Spark, and Azure Data Factory
* Use Azure Databricks or Synapse Spark to process data using Notebooks
* Design security using RBAC, ACL, encryption, data masking, and more
* Monitor and optimize data pipelines with debugging tips

If you feel this book is for you, get your [copy](https://www.amazon.com/dp/B09N73BVDQ) today!

<a href="https://www.packtpub.com/?utm_source=github&utm_medium=banner&utm_campaign=GitHubBanner"><img src="https://raw.githubusercontent.com/PacktPublishing/GitHub/master/GitHub.png" 
alt="https://www.packtpub.com/" border="5" /></a>


## Instructions and Navigations
All of the code is organized into folders.

The code will look like the following:
```
SELECT trip.[tripId], customer.[name] FROM 
dbo.FactTrips AS trip
JOIN dbo.DimCustomer AS customer
ON trip.[customerId] = customer.[customerId] 
WHERE trip.[endLocation] = 'San Jose';
```

**Following is what you need for this book:**
This book is for data engineers who want to take the DP-203: Azure Data Engineer Associate exam and are looking to gain in-depth knowledge of the Azure cloud stack.
The book will also help engineers and product managers who are new to Azure or interviewing with companies working on Azure technologies, to get hands-on experience of Azure data technologies. 
A basic understanding of cloud technologies, extract, transform, and load (ETL), and databases will help you get the most out of this book.

With the following software and hardware list you can run all code files present in the book (Chapter 1-15).

### Software and Hardware List

| Chapter  | Software required                   | OS required                        |
| -------- | ------------------------------------| -----------------------------------|
| 1-15	   | Azure account (free or paid)        | Windows, Mac OS X, and Linux (Any) |
| 1-15     | Azure CLI                           | Windows, Mac OS X, and Linux (Any) |


We also provide a PDF file that has color images of the screenshots/diagrams used in this book. [Click here to download it](https://static.packt-cdn.com/downloads/9781801816069_ColorImages.pdf).


### Related products <Other books you may enjoy>
* Azure Data Scientist Associate Certification Guide [[Packt]](https://www.packtpub.com/product/azure-data-scientist-associate-certification-guide/9781800565005?utm_source=github&utm_medium=repository&utm_campaign=9781800565005) [[Amazon]](https://www.amazon.com/dp/1800565003)

* Data Engineering with Apache Spark, Delta Lake, and Lakehouse [[Packt]](https://www.packtpub.com/product/data-engineering-with-apache-spark-delta-lake-and-lakehouse/9781801077743?utm_source=github&utm_medium=repository&utm_campaign=9781801077743) [[Amazon]](https://www.amazon.com/dp/1801077746)

## Get to Know the Authors
**Newton Alex** 
leads several Azure Data Analytics teams in Microsoft, India. His team contributes to technologies including Azure Synapse, Azure Databricks, Azure HDInsight, and many open source technologies, including Apache YARN, Apache Spark, and Apache Hive.
He started using Hadoop while at Yahoo, USA, where he helped build the first batch processing pipelines for Yahoo’s ad serving team. 
After Yahoo, he became the leader of the big data team at Pivotal Inc., USA, where he was responsible for the entire open source stack of Pivotal Inc. 
He later moved to Microsoft and started the Azure Data team in India. 
He has worked with several Fortune 500 companies to help build their data systems on Azure.
### Download a free PDF

 <i>If you have already purchased a print or Kindle version of this book, you can get a DRM-free PDF version at no cost.<br>Simply click on the link to claim your free PDF.</i>
<p align="center"> <a href="https://packt.link/free-ebook/9781801816069">https://packt.link/free-ebook/9781801816069 </a> </p>