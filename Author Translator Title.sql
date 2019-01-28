SELECT
	ILGAS.Translator.Name,
	ILGAS.TranslatorTrack.Title,
	ILGAS.Author.Name
FROM
	ILGAS.Author
	INNER JOIN ILGAS.Application_Author
	 ON ILGAS.Author.idAuthor = ILGAS.Application_Author.idAuthor
	INNER JOIN ILGAS.TranslatorTrack
	 ON ILGAS.Application_Author.ReferenceNumber = ILGAS.TranslatorTrack.ReferenceNumber
	INNER JOIN ILGAS.Translator
	 ON ILGAS.TranslatorTrack.idTranslator = ILGAS.Translator.idTranslator
WHERE
	ILGAS.Translator.idTranslator = 1165