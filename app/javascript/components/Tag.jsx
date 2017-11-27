import React from 'react';

export default class Tag extends React.Component {
  render() {
    const tag = this.props.tag;
    return (
      <div className="tag-wrap">
        <label className="btn btn-sm btn-secondary tag">
          <input
            type="radio"
            key={tag.name}
            value={tag.name}
            name="filterrific[with_tag][]"
            id={'filterrific_with_tag_' + tag.name}
            autoComplete="off"
            style={{ appearance: 'none', display: 'none' }}>
          </input>
          {tag.name}
        </label>
      </div>
    );
  }
}
