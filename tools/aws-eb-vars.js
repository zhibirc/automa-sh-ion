/**
 * Helper for import/export of environment variables (set of key-value pairs) in AWS Elastic Beanstalk console.
 *
 * The problem is that there is no standard way in UI to save/export environment variables added to configuration.
 * The same is for input/import a bunch of environment variables on environment creation, for example.
 *
 * Just to copy-paste this one, open DevTools on Configuration > Software page where environment variables are located.
 * Then use pull or push depending on you needs.
 */

const AWSBeanstalkEnvVarsFiller = {
  _getHTMLRows: () => {
    const table = document.querySelector('.properties-table');

    return table.querySelectorAll('tbody tr:not(.table-input-error)');
  },
  pull: function () {
    const rows = this._getHTMLRows();
    const data = {};

    Array.prototype.forEach.call(rows, row => {
      const [key, value] = row.getElementsByTagName('input');

      key.value && (data[key.value] = value.value);
    });

    return data;
  },
  push: function ( data ) {
    // it's only one row on start
    let row = this._getHTMLRows()[0];

    Object.keys(data).forEach(name => {
      const [key, value] = row.getElementsByTagName('input');

      key.value = name;
      value.value = data[name];

      // it's important step, because there is only one row in UI on start
      // and next row appears only when current is changed, so emulate manual fulfillment
      // additionally this corrects class names for inputs which now looks like filled by human
      $(key).change();
      $(value).change();
      row = [...this._getHTMLRows()].pop();
    });
  }
};

