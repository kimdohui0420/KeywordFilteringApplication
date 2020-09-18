package Keyword.content.domain;

public class GenreVO {
    private String contentId;
    private String genre;

    public String getContentId() {
        return contentId;
    }

    public String getGenre() {
        return genre;
    }

    public void setContentId(String contentId) {
        this.contentId = contentId;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    @Override
    public String toString() {
        return "GenreVO{" +
                "contentId='" + contentId + '\'' +
                ", genre='" + genre + '\'' +
                '}';
    }
}
