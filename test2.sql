SELECT
	ILGAS.GrantApplication.ReferenceNumber,
	ILGAS.GrantApplication.company,
	ILGAS.GrantApplication.agreementDocName,
	ILGAS.Author.FirstName,
	ILGAS.Author.LastName,
	ILGAS.Author.Name
FROM
	ILGAS.Application_Author
	INNER JOIN ILGAS.GrantApplication
	 ON ILGAS.Application_Author.ReferenceNumber = ILGAS.GrantApplication.ReferenceNumber
	INNER JOIN ILGAS.Author
	 ON ILGAS.Application_Author.idAuthor = ILGAS.Author.idAuthor
WHERE
	ILGAS.GrantApplication.ReferenceNumber = '6/2018'