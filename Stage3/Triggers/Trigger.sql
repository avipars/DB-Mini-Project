-- Trigger 1: When a book is deleted, log the deletion to a journal
CREATE TABLE IF NOT EXISTS Book_Log
(
  Log_ID SERIAL PRIMARY KEY,
  Book_ID INT NOT NULL,
  Title VARCHAR(1000) NOT NULL,
  Deleted_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION log_book_deletion()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO Book_Log (Book_ID, Title, Deleted_At)
  VALUES (OLD.ID, OLD.Title, CURRENT_TIMESTAMP);

  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS book_delete_trigger ON Book;

CREATE TRIGGER book_delete_trigger
AFTER DELETE ON Book
FOR EACH ROW
EXECUTE FUNCTION log_book_deletion();

-- Trigger 2: if a book gets classified as an eBook, we change its Condition and Location as required
CREATE OR REPLACE FUNCTION update_condition_for_ebook()
RETURNS TRIGGER AS $$
BEGIN
  -- Check if the book format is changed to 'eBook'
  IF TG_OP = 'UPDATE' AND NEW.Format = 'Ebook' AND OLD.Format != 'Ebook' THEN
    -- Update the Condition to 'NEW' in the Location table for the book
    UPDATE Location
    SET Condition = 'New', Floor = 'E-Library Section', Shelf = 1
    WHERE ID = NEW.ID;
  END IF;
    -- Handle when a new eBook is inserted
  IF TG_OP = 'INSERT' AND NEW.Format = 'Ebook' THEN
    -- Automatically add the eBook to the Location table with the 'New' condition and 'E-Library Section' floor
    -- Location ID for these eBooks is the same as BookID for simplicity
    INSERT INTO Location (Quantity, Floor, Shelf, Condition, ID, Location_ID)
    VALUES (1, 'E-Library Section', 1, 'New', NEW.ID, NEW.ID);
  END IF;


  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_condition_on_ebook_format ON Book;

CREATE TRIGGER update_condition_on_ebook_format
AFTER UPDATE ON Book
FOR EACH ROW
WHEN (OLD.Format != NEW.Format AND NEW.Format = 'Ebook')
EXECUTE FUNCTION update_condition_for_ebook();

DROP TRIGGER IF EXISTS insert_condition_on_new_ebook ON Book;

CREATE TRIGGER insert_condition_on_new_ebook
AFTER INSERT ON Book
FOR EACH ROW
WHEN (NEW.Format = 'Ebook')
EXECUTE FUNCTION update_condition_for_ebook();
