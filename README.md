![GitHub license](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)
![html](https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white)
# TPE XML - Group 10

---

## Description
The TPE (Trabajo Práctico Especial) is a script designed to process and validate XML data related to congress information. It automates the process of downloading data files, validating them against specific schemas, and combining multiple XML files into a unified dataset. Once the XML data is prepared and validated, the script generates an HTML report that summarizes the congress information in a user-friendly format. This report can be used for further analysis or presentation of congress-related data.
## Participants
- [Pedro Gonzalez Nuñez]()
- [Jerónimo Lopez Villa]()
- [Carolina Luciana Laurenza]()
- [Federico Spivak]()


---
# How to run the project?

## 1. First step:
Make sure to have the api key in your environment variables.

**`./zshrc`**
```bash 
...
export CONGRESS_API="insert_your_api_key_here"
...
```

## 2. Second step:
To run the project, you must run the following command in the terminal:

```bash
./tpe.sh CONGRESS_NUMBER
```
Where CONGRESS_NUMBER is the number of the congress you want to search for.
CONGRESS_NUMBER must be a number between 1 and 118, in order to get a proper output.


