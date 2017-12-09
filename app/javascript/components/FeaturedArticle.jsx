import PropTypes from 'prop-types';
import React from 'react';
import Tag from './Tag';

export default class FeaturedArticle extends React.Component {
  render() {
    const article = this.props.article
    const fullName = `${article.author_first_name} ${article.author_last_name}`
    const imageTitle = `${article.title} by ${fullName}`
    const tags = article.tags.map(t => t.name).join(",")
    const classs = this.props.className
    return (
      <div className={classs}>
        <a href={article.url} target="_blank">
          <img className="d-flex w-100" src={article.image} alt={imageTitle} />

          <div className="carousel-caption d-none d-flex h-100 align-items-center justify-content-center">
            <p>
              <h1>
                {article.title}
              </h1>
              by {fullName} for {article.site_name}
              <br />
              {article.description}
            </p>
          </div>
        </a>
      </div>
    )
  }
}

FeaturedArticle.propTypes = {
  article: PropTypes.object.isRequired,
};
