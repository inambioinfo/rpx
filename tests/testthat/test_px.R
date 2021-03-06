test_that("PXD000001", {
    id <- "PXD000001"
    px1 <- PXDataset(id)
    expect_null(show(px1))
    expect_identical(pxid(px1), id)
    ## Assertions manually looked up at
    url <- "ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2012/03/PXD000001"
    pxf <- pxfiles(px1)
    fls <- sort(c("F063721.dat",
                  "F063721.dat-mztab.txt",
                  "PRIDE_Exp_Complete_Ac_22134.xml.gz",
                  "PRIDE_Exp_mzData_Ac_22134.xml.gz",
                  "PXD000001_mztab.txt",
                  "TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01.mzXML",
                  "TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01.raw",
                  "TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01-20141210.mzML",
                  "TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01-20141210.mzXML",
                  "erwinia_carotovora.fasta"))
    expect_identical(length(pxf), 10L)
    expect_identical(sort(pxf), fls)
    expect_identical(pxtax(px1), "Erwinia carotovora")
    expect_identical(pxurl(px1), url)
    ref <- "Gatto L, Christoforou A. Using R and Bioconductor for proteomics data analysis. Biochim Biophys Acta. 2014 Jan;1844(1 Pt A):42-51. Review"
    expect_identical(pxref(px1), ref)
    fa <- pxget(px1, "erwinia_carotovora.fasta")
    expect_equal(length(Biostrings::readAAStringSet(fa)), 4499)
})


test_that("PXD version", {
    p <- PXDataset("PXD000001")
    expect_identical(p@formatVersion, c(formatVersion = "1.2.0"))
    p <- PXDataset("PXD000561")
    expect_identical(p@formatVersion, c(formatVersion = "1.2.0"))
    p <- PXDataset("PXD004938")
    expect_identical(p@formatVersion, c(formatVersion = "1.3.0"))
})

test_that("PX announcements", {
    pa <- pxannounced()
    expect_is(pa, "data.frame")
    expect_identical(names(pa),
                     c("Data.Set", "Publication.Data",
                       "Message"))
})

test_that("PX identifiers", {
    expect_error(PXDataset("P1"))
    expect_warning(px1 <- PXDataset("1"))
    expect_warning(px2 <- PXDataset("PXD1"))
    px3 <- PXDataset("PXD000001")
    expect_identical(px1, px2)
    expect_identical(px1, px2)
})

test_that("PX nodes", {
    px1 <- PXDataset("PXD000001")
    nd <- pxnodes(px1)
    nd0 <- c("CvList", "ChangeLog", "DatasetSummary",
             "DatasetIdentifierList", "DatasetOriginList", "SpeciesList",
             "InstrumentList", "ModificationList", "ContactList",
             "PublicationList", "KeywordList", "FullDatasetLinkList",
             "DatasetFileList", "RepositoryRecordList")
    expect_identical(nd, nd0)
    cvnd <- pxnodes(px1, "CvList")
    expect_identical(cvnd, rep("Cv", 4))
    allnd <- pxnodes(px1, all = TRUE)
    allnd0 <-
        c("/CvList/name", "/CvList//Cv/name",
          "/CvList//Cv/attributes/fullName", "/CvList//Cv/attributes/uri",
          "/CvList//Cv/attributes/id", "/CvList//Cv/name",
          "/CvList//Cv/attributes/fullName", "/CvList//Cv/attributes/uri",
          "/CvList//Cv/attributes/id", "/CvList//Cv/name",
          "/CvList//Cv/attributes/fullName", "/CvList//Cv/attributes/uri",
          "/CvList//Cv/attributes/id", "/CvList//Cv/name",
          "/CvList//Cv/attributes/fullName", "/CvList//Cv/attributes/uri",
          "/CvList//Cv/attributes/id", "/ChangeLog/name",
          "/ChangeLog//ChangeLogEntry/name",
          "/ChangeLog//ChangeLogEntry/attributes/date",
          "/ChangeLog//ChangeLogEntry//text/name",
          "/ChangeLog//ChangeLogEntry//text/value", "/DatasetSummary/name",
          "/DatasetSummary/attributes/announceDate",
          "/DatasetSummary/attributes/hostingRepository",
          "/DatasetSummary/attributes/title",
          "/DatasetSummary//Description/name",
          "/DatasetSummary//Description//text/name",
          "/DatasetSummary//Description//text/value",
          "/DatasetSummary//ReviewLevel/name",
          "/DatasetSummary//ReviewLevel//cvParam/name",
          "/DatasetSummary//ReviewLevel//cvParam/attributes/cvRef",
          "/DatasetSummary//ReviewLevel//cvParam/attributes/accession",
          "/DatasetSummary//ReviewLevel//cvParam/attributes/name",
          "/DatasetSummary//RepositorySupport/name",
          "/DatasetSummary//RepositorySupport//cvParam/name",
          "/DatasetSummary//RepositorySupport//cvParam/attributes/cvRef",
          "/DatasetSummary//RepositorySupport//cvParam/attributes/accession",
          "/DatasetSummary//RepositorySupport//cvParam/attributes/name",
          "/DatasetIdentifierList/name",
          "/DatasetIdentifierList//DatasetIdentifier/name",
          "/DatasetIdentifierList//DatasetIdentifier//cvParam/name",
          "/DatasetIdentifierList//DatasetIdentifier//cvParam/attributes/cvRef",
          "/DatasetIdentifierList//DatasetIdentifier//cvParam/attributes/accession",
          "/DatasetIdentifierList//DatasetIdentifier//cvParam/attributes/name",
          "/DatasetIdentifierList//DatasetIdentifier//cvParam/attributes/value",
          "/DatasetIdentifierList//DatasetIdentifier/name",
          "/DatasetIdentifierList//DatasetIdentifier//cvParam/name",
          "/DatasetIdentifierList//DatasetIdentifier//cvParam/attributes/cvRef",
          "/DatasetIdentifierList//DatasetIdentifier//cvParam/attributes/accession",
          "/DatasetIdentifierList//DatasetIdentifier//cvParam/attributes/name",
          "/DatasetIdentifierList//DatasetIdentifier//cvParam/attributes/value",
          "/DatasetOriginList/name", "/DatasetOriginList//DatasetOrigin/name",
          "/DatasetOriginList//DatasetOrigin//cvParam/name",
          "/DatasetOriginList//DatasetOrigin//cvParam/attributes/cvRef",
          "/DatasetOriginList//DatasetOrigin//cvParam/attributes/accession",
          "/DatasetOriginList//DatasetOrigin//cvParam/attributes/name",
          "/SpeciesList/name", "/SpeciesList//Species/name",
          "/SpeciesList//Species//cvParam/name",
          "/SpeciesList//Species//cvParam/attributes/cvRef",
          "/SpeciesList//Species//cvParam/attributes/accession",
          "/SpeciesList//Species//cvParam/attributes/name",
          "/SpeciesList//Species//cvParam/attributes/value",
          "/SpeciesList//Species//cvParam/name",
          "/SpeciesList//Species//cvParam/attributes/cvRef",
          "/SpeciesList//Species//cvParam/attributes/accession",
          "/SpeciesList//Species//cvParam/attributes/name",
          "/SpeciesList//Species//cvParam/attributes/value",
          "/InstrumentList/name", "/InstrumentList//Instrument/name",
          "/InstrumentList//Instrument/attributes/id",
          "/InstrumentList//Instrument//cvParam/name",
          "/InstrumentList//Instrument//cvParam/attributes/cvRef",
          "/InstrumentList//Instrument//cvParam/attributes/accession",
          "/InstrumentList//Instrument//cvParam/attributes/name",
          "/InstrumentList//Instrument//cvParam/attributes/value",
          "/InstrumentList//Instrument/name",
          "/InstrumentList//Instrument/attributes/id",
          "/InstrumentList//Instrument//cvParam/name",
          "/InstrumentList//Instrument//cvParam/attributes/cvRef",
          "/InstrumentList//Instrument//cvParam/attributes/accession",
          "/InstrumentList//Instrument//cvParam/attributes/name",
          "/ModificationList/name", "/ModificationList//cvParam/name",
          "/ModificationList//cvParam/attributes/cvRef",
          "/ModificationList//cvParam/attributes/accession",
          "/ModificationList//cvParam/attributes/name",
          "/ModificationList//cvParam/name",
          "/ModificationList//cvParam/attributes/cvRef",
          "/ModificationList//cvParam/attributes/accession",
          "/ModificationList//cvParam/attributes/name",
          "/ModificationList//cvParam/name",
          "/ModificationList//cvParam/attributes/cvRef",
          "/ModificationList//cvParam/attributes/accession",
          "/ModificationList//cvParam/attributes/name", "/ContactList/name",
          "/ContactList//Contact/name", "/ContactList//Contact/attributes/id",
          "/ContactList//Contact//cvParam/name",
          "/ContactList//Contact//cvParam/attributes/cvRef",
          "/ContactList//Contact//cvParam/attributes/accession",
          "/ContactList//Contact//cvParam/attributes/name",
          "/ContactList//Contact//cvParam/attributes/value",
          "/ContactList//Contact//cvParam/name",
          "/ContactList//Contact//cvParam/attributes/cvRef",
          "/ContactList//Contact//cvParam/attributes/accession",
          "/ContactList//Contact//cvParam/attributes/name",
          "/ContactList//Contact//cvParam/attributes/value",
          "/ContactList//Contact//cvParam/name",
          "/ContactList//Contact//cvParam/attributes/cvRef",
          "/ContactList//Contact//cvParam/attributes/accession",
          "/ContactList//Contact//cvParam/attributes/name",
          "/ContactList//Contact//cvParam/attributes/value",
          "/ContactList//Contact//cvParam/name",
          "/ContactList//Contact//cvParam/attributes/cvRef",
          "/ContactList//Contact//cvParam/attributes/accession",
          "/ContactList//Contact//cvParam/attributes/name",
          "/PublicationList/name", "/PublicationList//Publication/name",
          "/PublicationList//Publication/attributes/id",
          "/PublicationList//Publication//cvParam/name",
          "/PublicationList//Publication//cvParam/attributes/cvRef",
          "/PublicationList//Publication//cvParam/attributes/accession",
          "/PublicationList//Publication//cvParam/attributes/name",
          "/PublicationList//Publication//cvParam/attributes/value",
          "/PublicationList//Publication//cvParam/name",
          "/PublicationList//Publication//cvParam/attributes/cvRef",
          "/PublicationList//Publication//cvParam/attributes/accession",
          "/PublicationList//Publication//cvParam/attributes/name",
          "/PublicationList//Publication//cvParam/attributes/value",
          "/KeywordList/name", "/KeywordList//cvParam/name",
          "/KeywordList//cvParam/attributes/cvRef",
          "/KeywordList//cvParam/attributes/accession",
          "/KeywordList//cvParam/attributes/name",
          "/KeywordList//cvParam/attributes/value",
          "/KeywordList//cvParam/name",
          "/KeywordList//cvParam/attributes/cvRef",
          "/KeywordList//cvParam/attributes/accession",
          "/KeywordList//cvParam/attributes/name",
          "/KeywordList//cvParam/attributes/value", "/FullDatasetLinkList/name",
          "/FullDatasetLinkList//FullDatasetLink/name",
          "/FullDatasetLinkList//FullDatasetLink//cvParam/name",
          "/FullDatasetLinkList//FullDatasetLink//cvParam/attributes/cvRef",
          "/FullDatasetLinkList//FullDatasetLink//cvParam/attributes/accession",
          "/FullDatasetLinkList//FullDatasetLink//cvParam/attributes/name",
          "/FullDatasetLinkList//FullDatasetLink//cvParam/attributes/value",
          "/FullDatasetLinkList//FullDatasetLink/name",
          "/FullDatasetLinkList//FullDatasetLink//cvParam/name",
          "/FullDatasetLinkList//FullDatasetLink//cvParam/attributes/cvRef",
          "/FullDatasetLinkList//FullDatasetLink//cvParam/attributes/accession",
          "/FullDatasetLinkList//FullDatasetLink//cvParam/attributes/name",
          "/FullDatasetLinkList//FullDatasetLink//cvParam/attributes/value",
          "/DatasetFileList/name", "/DatasetFileList//DatasetFile/name",
          "/DatasetFileList//DatasetFile/attributes/id",
          "/DatasetFileList//DatasetFile/attributes/name",
          "/DatasetFileList//DatasetFile//cvParam/name",
          "/DatasetFileList//DatasetFile//cvParam/attributes/cvRef",
          "/DatasetFileList//DatasetFile//cvParam/attributes/accession",
          "/DatasetFileList//DatasetFile//cvParam/attributes/name",
          "/DatasetFileList//DatasetFile//cvParam/attributes/value",
          "/DatasetFileList//DatasetFile/name",
          "/DatasetFileList//DatasetFile/attributes/id",
          "/DatasetFileList//DatasetFile/attributes/name",
          "/DatasetFileList//DatasetFile//cvParam/name",
          "/DatasetFileList//DatasetFile//cvParam/attributes/cvRef",
          "/DatasetFileList//DatasetFile//cvParam/attributes/accession",
          "/DatasetFileList//DatasetFile//cvParam/attributes/name",
          "/DatasetFileList//DatasetFile//cvParam/attributes/value",
          "/DatasetFileList//DatasetFile/name",
          "/DatasetFileList//DatasetFile/attributes/id",
          "/DatasetFileList//DatasetFile/attributes/name",
          "/DatasetFileList//DatasetFile//cvParam/name",
          "/DatasetFileList//DatasetFile//cvParam/attributes/cvRef",
          "/DatasetFileList//DatasetFile//cvParam/attributes/accession",
          "/DatasetFileList//DatasetFile//cvParam/attributes/name",
          "/DatasetFileList//DatasetFile//cvParam/attributes/value",
          "/DatasetFileList//DatasetFile/name",
          "/DatasetFileList//DatasetFile/attributes/id",
          "/DatasetFileList//DatasetFile/attributes/name",
          "/DatasetFileList//DatasetFile//cvParam/name",
          "/DatasetFileList//DatasetFile//cvParam/attributes/cvRef",
          "/DatasetFileList//DatasetFile//cvParam/attributes/accession",
          "/DatasetFileList//DatasetFile//cvParam/attributes/name",
          "/DatasetFileList//DatasetFile//cvParam/attributes/value",
          "/DatasetFileList//DatasetFile/name",
          "/DatasetFileList//DatasetFile/attributes/id",
          "/DatasetFileList//DatasetFile/attributes/name",
          "/DatasetFileList//DatasetFile//cvParam/name",
          "/DatasetFileList//DatasetFile//cvParam/attributes/cvRef",
          "/DatasetFileList//DatasetFile//cvParam/attributes/accession",
          "/DatasetFileList//DatasetFile//cvParam/attributes/name",
          "/DatasetFileList//DatasetFile//cvParam/attributes/value",
          "/DatasetFileList//DatasetFile/name",
          "/DatasetFileList//DatasetFile/attributes/id",
          "/DatasetFileList//DatasetFile/attributes/name",
          "/DatasetFileList//DatasetFile//cvParam/name",
          "/DatasetFileList//DatasetFile//cvParam/attributes/cvRef",
          "/DatasetFileList//DatasetFile//cvParam/attributes/accession",
          "/DatasetFileList//DatasetFile//cvParam/attributes/name",
          "/DatasetFileList//DatasetFile//cvParam/attributes/value",
          "/DatasetFileList//DatasetFile/name",
          "/DatasetFileList//DatasetFile/attributes/id",
          "/DatasetFileList//DatasetFile/attributes/name",
          "/DatasetFileList//DatasetFile//cvParam/name",
          "/DatasetFileList//DatasetFile//cvParam/attributes/cvRef",
          "/DatasetFileList//DatasetFile//cvParam/attributes/accession",
          "/DatasetFileList//DatasetFile//cvParam/attributes/name",
          "/DatasetFileList//DatasetFile//cvParam/attributes/value",
          "/DatasetFileList//DatasetFile/name",
          "/DatasetFileList//DatasetFile/attributes/id",
          "/DatasetFileList//DatasetFile/attributes/name",
          "/DatasetFileList//DatasetFile//cvParam/name",
          "/DatasetFileList//DatasetFile//cvParam/attributes/cvRef",
          "/DatasetFileList//DatasetFile//cvParam/attributes/accession",
          "/DatasetFileList//DatasetFile//cvParam/attributes/name",
          "/DatasetFileList//DatasetFile//cvParam/attributes/value",
          "/RepositoryRecordList/name",
          "/RepositoryRecordList//RepositoryRecord/name",
          "/RepositoryRecordList//RepositoryRecord/attributes/name",
          "/RepositoryRecordList//RepositoryRecord/attributes/label",
          "/RepositoryRecordList//RepositoryRecord/attributes/recordID",
          "/RepositoryRecordList//RepositoryRecord/attributes/repositoryID",
          "/RepositoryRecordList//RepositoryRecord/attributes/uri")
    expect_identical(allnd, allnd0)
})
