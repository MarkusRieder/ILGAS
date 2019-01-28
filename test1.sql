SELECT
	ILGAS.GrantApplication.company,
	ILGAS.GrantApplication.agreementDocName,
	ILGAS.GrantApplication.ApplicationNumber,
	ILGAS.GrantApplication.ApplicationYear,
	(SELECT
		ILGAS.Author.FirstName,
		ILGAS.Author.LastName,
		ILGAS.Author.Name
	 FROM
		ILGAS.Author
		INNER JOIN ILGAS.Application_Author
		 ON ILGAS.Author.idAuthor = ILGAS.Application_Author.idAuthor
	 WHERE
		ILGAS.GrantApplication.ReferenceNumber = 6/2018)
FROM
	Author
	INNER JOIN ILGAS.GrantApplication
	 ON ILGAS.Author.ReferenceNumber = ILGAS.GrantApplication.ReferenceNumber