import React, { useState, useEffect, useRef, useMemo } from 'react';
import './App.css';
import { supabase } from './lib/supabase';

interface PCComponent {
  id: number;
  category: string;
  name: string;
  price: number;
  details?: Record<string, string | number>;
}

interface SearchableDropdownProps {
  category: string;
  items: PCComponent[];
  selectedItem: PCComponent | null;
  onSelect: (item: PCComponent | null) => void;
}

const SearchableDropdown = ({ category, items, selectedItem, onSelect }: SearchableDropdownProps) => {
  const [isOpen, setIsOpen] = useState(false);
  const [searchTerm, setSearchTerm] = useState('');
  const wrapperRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    function handleClickOutside(event: MouseEvent) {
      if (wrapperRef.current && !wrapperRef.current.contains(event.target as Node)) {
        setIsOpen(false);
      }
    }
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setSearchTerm(e.target.value);
    setIsOpen(true);
    if (selectedItem) onSelect(null);
  };

  const handleSelectItem = (item: PCComponent) => {
    onSelect(item);
    setSearchTerm(item.name);
    setIsOpen(false);
  };

  const handleClear = () => {
    onSelect(null);
    setSearchTerm('');
    setIsOpen(true);
  };

  const showAll = selectedItem && searchTerm === selectedItem.name;
  const filteredItems = showAll
    ? items
    : items.filter((item) =>
        item.name.toLowerCase().includes(searchTerm.toLowerCase())
      );

  return (
    <div
      className="searchable-dropdown"
      ref={wrapperRef}
      style={{ zIndex: isOpen ? 100 : 1 }}
    >
      <label>{category}</label>
      <div className="input-wrapper">
        <input
          type="text"
          placeholder={`Search ${category}...`}
          value={searchTerm}
          onChange={handleInputChange}
          onFocus={(e) => {
            setIsOpen(true);
            e.target.select();
          }}
        />
        {selectedItem && (
          <button className="clear-btn" onClick={handleClear}>✕</button>
        )}
      </div>

      {isOpen && (
        <ul className="suggestions-list">
          {filteredItems.length > 0 ? (
            filteredItems.map((item) => (
              <li
                key={item.id}
                onMouseDown={() => handleSelectItem(item)}
              >
                <span className="item-name">{item.name}</span>
                <span className="item-price">₹{item.price.toLocaleString('en-IN')}</span>
              </li>
            ))
          ) : (
            <li className="no-results">No {category} found</li>
          )}
        </ul>
      )}
    </div>
  );
};

export default function App() {
  const [components, setComponents] = useState<PCComponent[]>([]);
  const [selectedParts, setSelectedParts] = useState<Record<string, PCComponent>>({});
  const [isDarkMode, setIsDarkMode] = useState(false);
  const [loading, setLoading] = useState(true);
  const [fetchError, setFetchError] = useState<string | null>(null);

  useEffect(() => {
    document.documentElement.setAttribute('data-theme', isDarkMode ? 'dark' : 'light');
  }, [isDarkMode]);

  useEffect(() => {
    supabase
      .from('components')
      .select('*')
      .order('category')
      .order('price')
      .then(({ data, error }) => {
        if (error) {
          console.error('Failed to fetch components:', error);
          setFetchError('Failed to load components. Please refresh the page.');
        } else {
          setComponents((data ?? []) as PCComponent[]);
        }
        setLoading(false);
      });
  }, []);

  const categories = useMemo(
    () => Array.from(new Set(components.map((c) => c.category))),
    [components]
  );

  const handleSelect = (category: string, item: PCComponent | null) => {
    setSelectedParts((prev) => {
      const updated = { ...prev };
      if (item) updated[category] = item;
      else delete updated[category];
      return updated;
    });
  };

  const totalPrice = Object.values(selectedParts).reduce((sum, item) => sum + item.price, 0);

  return (
    <div className="app-container">
      <header className="top-bar hide-on-print">
        <div className="logo">
          <h1>PCMaxing</h1>
          <p>Design your PC | Check compatibility of components | Real time updated prices</p>
        </div>
        <button
          className="theme-toggle"
          onClick={() => setIsDarkMode(!isDarkMode)}
        >
          {isDarkMode ? '☀️ Light Mode' : '🌙 Dark Mode'}
        </button>
      </header>

      <main className="builder-layout">
        <aside className="specs-panel hide-on-print">
          <h2>Detailed Specs</h2>
          {Object.keys(selectedParts).length === 0 ? (
            <div className="empty-state">Select parts to see their specifications.</div>
          ) : (
            <div className="specs-container">
              {Object.values(selectedParts).map((part) => (
                <div key={part.id} className="spec-card">
                  <h4>{part.category}: {part.name}</h4>
                  {part.details ? (
                    <ul className="spec-list">
                      {Object.entries(part.details).map(([key, value]) => (
                        <li key={key}><strong>{key}:</strong> {value}</li>
                      ))}
                    </ul>
                  ) : (
                    <p className="no-specs">Detailed specs not available.</p>
                  )}
                </div>
              ))}
            </div>
          )}
        </aside>

        <div className="selectors hide-on-print">
          {loading && <div className="empty-state">Loading components...</div>}
          {fetchError && <div className="error-state">{fetchError}</div>}
          {!loading && !fetchError && categories.map((cat) => (
            <SearchableDropdown
              key={cat}
              category={cat}
              items={components.filter((c) => c.category === cat)}
              selectedItem={selectedParts[cat] ?? null}
              onSelect={(item) => handleSelect(cat, item)}
            />
          ))}
        </div>

        <aside className="invoice-section">
          <div className="invoice-header">
            <h2>Your Build</h2>
            <span className="part-count">{Object.keys(selectedParts).length} Parts</span>
          </div>

          {Object.keys(selectedParts).length === 0 ? (
            <div className="empty-state">Cart is empty.</div>
          ) : (
            <ul className="bill-items">
              {Object.values(selectedParts).map((part) => (
                <li key={part.id}>
                  <div className="bill-item-details">
                    <span className="bill-cat">{part.category}</span>
                    <span className="bill-name">{part.name}</span>
                  </div>
                  <span className="bill-price">₹{part.price.toLocaleString('en-IN')}</span>
                  {part.details && (
                    <div className="bill-item-specs">
                      {Object.entries(part.details).map(([key, value]) => (
                        <div key={key} className="spec-item">
                          <strong>{key}:</strong> {value}
                        </div>
                      ))}
                    </div>
                  )}
                </li>
              ))}
            </ul>
          )}

          <div className="total-row">
            <h3>Estimated Cost</h3>
            <h3 className="total-amount">₹{totalPrice.toLocaleString('en-IN')}</h3>
          </div>

          <button
            onClick={() => window.print()}
            className="print-btn hide-on-print"
            disabled={Object.keys(selectedParts).length === 0}
          >
            Print
          </button>
        </aside>
      </main>
    </div>
  );
}
